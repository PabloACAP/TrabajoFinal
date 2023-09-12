Algoritmo indicadoresFinancierosRsiFIbonacci 
	Definir password, passwordGuardado como cadena;
	Definir precio, valorRsi, precioDiaAnterior, diferencia2Dias, cierreDia, subidaMedia, bajadaMedia Como Real;
	Definir periodos, exit Como Entero;
	
	passwordGuardado <- "Admin";
	
	
	Repetir //habilita el ingreso con clave
		Escribir "Ingrese su password: ";
		Leer password;
		Si password <> passwordGuardado Entonces
			Escribir "Password incorrecto";
		Fin Si
	Hasta Que password = passwordGuardado;
	
	
	Repetir
		Limpiar Pantalla;
		// resetear variables
		precio <- 0;
		valorRsi <- 0;
		subidaMedia <- 0;
		bajadaMedia <- 0;
		periodos <- 0;
		precioDiaAnterior <-0;
		diferencia2Dias <- 0;
		cierreDia <- 0;
		subidaMedia <- 0;
		bajadaMedia <- 0;
		exit <- 1;
		
		Escribir "Seleccione el indicador que desea evaluar"; // ofrece el menú de operaciones a realizar
		Escribir "1-RSI";
		Escribir "2-Retrocesos de Fibonacci";
		Leer indicador;
		
		Escribir "Ingrese el Ticket del activo que va a evaluar";
		Leer ticket; // Se ingresa el ticket tal cuál figura en el mercado de capitales (no hay restricción al respecto). Es sólo referencial. 
		
		Segun indicador Hacer 
			1://calcula RSI
				Escribir "Ingrese para cuántos períodos quiere evaluar el RSI o 0 si desea salir"; //normalmente se usa 9  o 14 períodos 
				Leer periodos;
				
				Escribir "Ingrese el precio del primer cierre"; // se ingresa el precio más antiguo primero hasta el último. Se necesitarán "períodos + 1" precios para poder calcularlo
				Leer precioDiaAnterior;
				
				Para cierreDia<- 2 Hasta periodos + 1 
					Escribir "Ingrese el precio de cierre del día: ", cierreDia;
					Leer precio;
					diferencia2Dias <- precio - precioDiaAnterior;
					Si diferencia2Dias >= 0 Entonces
						subidaMedia <- subidaMedia + diferencia2Dias;
					SiNo
						bajadaMedia <- bajadaMedia + (-1 * diferencia2Dias);
					Fin Si
					precioDiaAnterior <- precio;
				Fin Para
				
				valorRsi <- 100 - (100 / (1 + ((subidaMedia/periodos) / (bajadaMedia/periodos))));
				
				Mostrar "Activo: ", ticket;
				Mostrar "El valor del RSI es ", valorRsi;
				
				Si valorRsi >= 70 Entonces //realiza la recomendación según el rsi calculado
					Escribir "VENTA";
				SiNo
					Si valorRsi <= 30 Entonces
						Escribir "COMPRA";
					SiNo
						Escribir "MANTENER";
					Fin Si
				Fin Si
				
			2://determina las bandas del retroceso de fibonacci
				Escribir "La tendencia es:";
				Escribir "1-Ascendente"; //Es tendencia ascendente si en el tiempo primero se dió el mínimo y posteriormente el máximo, de los precios, a evaluar.
				Escribir "2-Descendente"; //Es tendencia descendente si en el tiempo primero se dió el máximo y posteriormente el mínimo, de los precios, a evaluar.
				Leer tendencia;
				
				Escribir "Ingrese el valor del máximo"; //Sin importar la tendencia se ingresará primero el máximo y luego el mínimo.
				Leer maximo;
				
				Escribir "Ingrese el valor del mínimo";
				Leer minimo;
				
				Si tendencia = 1 Entonces
					diferenciaMaxMin <- maximo - minimo;
					bandaDel236 <- maximo - (diferenciaMaxMin * 0.236); 
					bandaDel382 <- maximo - (diferenciaMaxMin * 0.382); 
					bandaDel618 <- maximo - (diferenciaMaxMin * 0.618); 
					bandaDel786 <- maximo - (diferenciaMaxMin * 0.786); 
				SiNo
					diferenciaMaxMin <- maximo - minimo;
					bandaDel236 <- (diferenciaMaxMin * 0.236) + minimo;
					bandaDel382 <- (diferenciaMaxMin * 0.382) + minimo;
					bandaDel618 <- (diferenciaMaxMin * 0.618) + minimo;
					bandaDel786 <- (diferenciaMaxMin * 0.786) + minimo;
				Fin Si
				
				Mostrar "Ticket: ", ticket;
				
				Si tendencia = 1 Entonces
					Mostrar "Tendencia ascendente";
					Mostrar "Banda del 23,6%: ", bandaDel236;
					Mostrar "banda del 38,2%: ", bandaDel382;
					Mostrar "Banda del 61,8%: ", bandaDel618;
					Mostrar "Banda del 78,6%: ", bandaDel786;
				SiNo
					Mostrar "Tendencia descendente";
					Mostrar "Banda del 23,6%: ", bandaDel236;
					Mostrar "banda del 38,2%: ", bandaDel382;
					Mostrar "Banda del 61,8%: ", bandaDel618;
					Mostrar "Banda del 78,6%: ", bandaDel786;
				FinSi
				
				De Otro Modo:
				Escribir "Ingrese una opción válida";
		Fin Segun
		
		Escribir "Presiones 1 y ENTER para realizar otra operación o 2 y ENTER para salir"; //seleccionar seguir calculando o salir
		Leer exit;
		
	Hasta Que exit = 2; //hacer que salga del programa
		
FinAlgoritmo

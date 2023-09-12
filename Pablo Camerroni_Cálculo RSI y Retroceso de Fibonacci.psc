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
		
		Escribir "Seleccione el indicador que desea evaluar"; // ofrece el men� de operaciones a realizar
		Escribir "1-RSI";
		Escribir "2-Retrocesos de Fibonacci";
		Leer indicador;
		
		Escribir "Ingrese el Ticket del activo que va a evaluar";
		Leer ticket; // Se ingresa el ticket tal cu�l figura en el mercado de capitales (no hay restricci�n al respecto). Es s�lo referencial. 
		
		Segun indicador Hacer 
			1://calcula RSI
				Escribir "Ingrese para cu�ntos per�odos quiere evaluar el RSI o 0 si desea salir"; //normalmente se usa 9  o 14 per�odos 
				Leer periodos;
				
				Escribir "Ingrese el precio del primer cierre"; // se ingresa el precio m�s antiguo primero hasta el �ltimo. Se necesitar�n "per�odos + 1" precios para poder calcularlo
				Leer precioDiaAnterior;
				
				Para cierreDia<- 2 Hasta periodos + 1 
					Escribir "Ingrese el precio de cierre del d�a: ", cierreDia;
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
				
				Si valorRsi >= 70 Entonces //realiza la recomendaci�n seg�n el rsi calculado
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
				Escribir "1-Ascendente"; //Es tendencia ascendente si en el tiempo primero se di� el m�nimo y posteriormente el m�ximo, de los precios, a evaluar.
				Escribir "2-Descendente"; //Es tendencia descendente si en el tiempo primero se di� el m�ximo y posteriormente el m�nimo, de los precios, a evaluar.
				Leer tendencia;
				
				Escribir "Ingrese el valor del m�ximo"; //Sin importar la tendencia se ingresar� primero el m�ximo y luego el m�nimo.
				Leer maximo;
				
				Escribir "Ingrese el valor del m�nimo";
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
				Escribir "Ingrese una opci�n v�lida";
		Fin Segun
		
		Escribir "Presiones 1 y ENTER para realizar otra operaci�n o 2 y ENTER para salir"; //seleccionar seguir calculando o salir
		Leer exit;
		
	Hasta Que exit = 2; //hacer que salga del programa
		
FinAlgoritmo

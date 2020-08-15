/*Display de 7 segmentos para visualização da Entrada e Saída*/

module Display7Segmentos (entrada, display);
	//BCD correspondente de entrada
	input [3:0] entrada;
	//Saída correspondente no display de 7 segmentos
	output reg [6:0] display;

	always @ (*) 
	begin
	display = 7'b1111111;
		case (entrada)
			//0
			4'b0000: display = 7'b1000000;
			//1
			4'b0001: display = 7'b1111001;
			//2
			4'b0010: display = 7'b0100100;
			//3
			4'b0011: display = 7'b0110000;
			//4
			4'b0100: display = 7'b0011001;
			//5
			4'b0101: display = 7'b0010010;
			//6
			4'b0110: display = 7'b0000011;
			//7
			4'b0111: display = 7'b1111000;
			//8
			4'b1000: display = 7'b0000000;
			//9
			4'b1001: display = 7'b0011000;
			//apagado
			default: display = 7'b1111111;
		endcase
	end
endmodule

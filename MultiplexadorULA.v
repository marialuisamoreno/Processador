/*Multiplexador da ULA do Processador*/

module MultiplexadorULA (flag, entrada1, entrada2, entrada3, entrada4, saida);
	//Entradas que serão selecionadas
	input [31:0] entrada1, entrada2, entrada3, entrada4;
	//Flag para indicar qual entrada será a saida
	input [1:0] flag;
	//Saída com a entrada escolhida
	output reg [31:0] saida;
	
	always @ (*) begin
		saida = 0;
		case (flag)
			//Se eu escolher a entrada 1
			2'b00: saida = entrada1;
			//Se eu escolher a entrada 2
			2'b01: saida = entrada2;
			//Se eu escolher a entrada 3
			2'b10: saida = entrada3;
			//Se eu escolher a entrada 4
			2'b11: saida = entrada4;
			//default
			default: saida = entrada1;
		endcase
	end
endmodule

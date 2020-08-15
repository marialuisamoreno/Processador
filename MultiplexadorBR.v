/*Multiplexador do Banco de Registradores do Processador*/

module MultiplexadorBR (flag, entrada1, entrada2, saida);
	//Entradas que serão selecionadas
	input [31:0] entrada1, entrada2;
	//Flag para indicar qual entrada será a saida
	input flag;
	//Saída com a entrada escolhida
	output reg [31:0] saida;
	
	always @ (*) begin
		case (flag)
			//Se eu escolher a entrada 1
			1'b0: saida = entrada1;
			//Se eu escolher a entrada 2
			1'b1: saida = entrada2;
		endcase
	end
endmodule

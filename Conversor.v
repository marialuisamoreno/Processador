/*Conversor de binário para BCD do módulo de Entrada e Saída
Baseado em: https://my.eng.utah.edu/~nmcdonal/Tutorials/BCDTutorial/BCDConversion.html*/

module Conversor (binario, ones, tens, hundreds, thousands, millions, flag);
	//Flag para indicar conversão
	input flag;
	//Entrada de 32 bits
	input [31:0] binario;
	//Saídas separadas por unidade
	output reg [3:0] ones, tens, hundreds, thousands, millions;
	//Variável auxiliar
	integer i;

	always @ (binario or flag) 
	begin
		i = 0;
		if(flag)
			begin  
				millions = 4'b0;
				thousands = 4'b0;
				hundreds = 4'b0;
				tens = 4'b0;
				ones = 4'b0;

				for(i=31; i>=0; i=i-1)
				begin
					if(millions >= 5) millions = millions + 3;
					if(thousands >= 5) thousands = thousands + 3;
					if(hundreds >= 5) hundreds = hundreds + 3;
					if (tens >= 5) tens = tens + 3;
					if(ones >=5) ones = ones + 3;
					  
					millions = millions << 1;
					millions[0] = thousands[3];
					thousands = thousands << 1;
					thousands[0] = hundreds[3];
					hundreds = hundreds << 1;
					hundreds[0] = tens[3];
					tens = tens << 1;
					tens[0] = ones[3];
					ones = ones << 1;
					ones[0] = binario[i];
				end 
			end
			else begin
				millions = 4'b1010;
				thousands = 4'b1010;
				hundreds = 4'b1010;
				tens = 4'b1010;
				ones = 4'b1010;
			end	
		
	end

endmodule 

/*Memória de Instruções do Processador*/

module MemoriaDeInstrucao (Endereco, Instrucao, clock);
	
	//Endereco de 32 bits do PC
	input [31:0] Endereco;
	//Variável do sinal do clock
	input clock;
	//Variável de controle de ciclo
	integer Ciclo = 0;	
	//Instrução de 32 bits
	output [31:0] Instrucao;
	//1024 memórias RAMs de 32 bits cada
	reg [31:0] RAM[63:0];

	always @ (posedge clock) 
	begin
		//Irá executar cada instrução em 1 ciclo de clock
		if(Ciclo == 0)
		begin
		
	/*		//Algoritmo Genérico
			RAM[0][31:27] = 5'b10000; //nop
			RAM[0][26:0]  = 0; 
				
			RAM[1][31:27] = 5'b10110; //in $1, input         (entrada)
			RAM[1][26:18] = 1; 
			RAM[1][17:0]  = 0;  
	
			RAM[2][31:27] = 5'b00101; //li $2, 1             (decremento)
			RAM[2][26:18] = 2; 
			RAM[2][17:9]  = 1; 
			RAM[2][8:0]   = 0;
		
	      RAM[3][31:27] = 5'b00101; //li $3, 5             (para multiplicação)
			RAM[3][26:18] = 3; 
			RAM[3][17:9]  = 5; 
			RAM[3][8:0]   = 0;
		
			RAM[4][31:27] = 5'b00101; //li $4, 2             (para divisão e resto)
			RAM[4][26:18] = 4; 
			RAM[4][17:9]  = 2; 
			RAM[4][8:0]   = 0;
			
			RAM[5][31:27] = 5'b00001; //sub $5, $1, $2       (n = entrada - 1)
			RAM[5][26:18] = 5;
			RAM[5][17:9]  = 1; 
			RAM[5][8:0]   = 2;
		
			RAM[6][31:27] = 5'b10111; //out $5               (mostro a resposta da subtração)
			RAM[6][26:18] = 5; 
			RAM[6][17:0]  = 0;
		
			RAM[7][31:27] = 5'b00011; //div $6, $1, $4       (n = entrada/2)
			RAM[7][26:18] = 6;
			RAM[7][17:9]  = 1; 
			RAM[7][8:0]   = 4;
		
			RAM[8][31:27] = 5'b10111; //out $6               (mostro a resposta da divisão)
			RAM[8][26:18] = 6; 
			RAM[8][17:0]  = 0;
		
			RAM[9][31:27] = 5'b00010; //mult $7, $1, $3      (n = entrada*5)
			RAM[9][26:18] = 7;
			RAM[9][17:9]  = 1; 
			RAM[9][8:0]   = 3;
		
			RAM[10][31:27] = 5'b10111; //out $7              (mostro a resposta da multiplicação)
			RAM[10][26:18] = 7; 
			RAM[10][17:0]  = 0;
			
			RAM[11][31:27] = 5'b00100; //resto $8, $1, $4    (n = entrada%2)
			RAM[11][26:18] = 8;
			RAM[11][17:9]  = 1; 
			RAM[11][8:0]   = 4;
		
			RAM[12][31:27] = 5'b10111; //out $8              (mostro a resposta do resto)
			RAM[12][26:18] = 8; 
			RAM[12][17:0]  = 0;
		
			RAM[13][31:27] = 5'b00111; //E $9, $1, $2        (n = entrada E 1)
			RAM[13][26:18] = 9;
			RAM[13][17:9]  = 1; 
			RAM[13][8:0]   = 2;
		
			RAM[14][31:27] = 5'b10111; //out $9              (mostro a resposta do AND)
			RAM[14][26:18] = 9; 
			RAM[14][17:0]  = 0;
			
			RAM[15][31:27] = 5'b01000; //OU $10, $1, $2      (n = entrada OU 1)
			RAM[15][26:18] = 10;
			RAM[15][17:9]  = 1; 
			RAM[15][8:0]   = 2;
		
			RAM[16][31:27] = 5'b10111; //out $10             (mostro a resposta do OR)
			RAM[16][26:18] = 10; 
			RAM[16][17:0]  = 0;
			
			RAM[17][31:27] = 5'b01001; //OU* $11, $1, $2     (n = entrada OU* 1)
			RAM[17][26:18] = 11;
			RAM[17][17:9]  = 1; 
			RAM[17][8:0]   = 2;
		
			RAM[18][31:27] = 5'b10111; //out $11             (mostro a resposta do OR*)
			RAM[18][26:18] = 11; 
			RAM[18][17:0]  = 0;
			
			RAM[19][31:27] = 5'b01010; //NOT $12, $1         (n = NOT entrada)
			RAM[19][26:18] = 12;
			RAM[19][17:9]  = 1; 
			RAM[19][8:0]   = 0;
		
			RAM[20][31:27] = 5'b10111; //out $12             (mostro a resposta do not)
			RAM[20][26:18] = 12; 
			RAM[20][17:0]  = 0;
			
			RAM[21][31:27] = 5'b01011; //RDIR $13, $1, $2    (n = entrada RDIR 1)
			RAM[21][26:18] = 13;
			RAM[21][17:9]  = 1; 
			RAM[21][8:0]   = 2;
		
			RAM[22][31:27] = 5'b10111; //out $13             (mostro a resposta do RDIR)
			RAM[22][26:18] = 13; 
			RAM[22][17:0]  = 0;
			
			RAM[23][31:27] = 5'b01100; //RESQ $14, $1, $2    (n = entrada RESQ 1)
			RAM[23][26:18] = 14;
			RAM[23][17:9]  = 1; 
			RAM[23][8:0]   = 2;
		
			RAM[24][31:27] = 5'b10111; //out $14             (mostro a resposta do RESQ)
			RAM[24][26:18] = 14; 
			RAM[24][17:0]  = 0;
			
			RAM[25][31:27] = 5'b01110; //MaiorQ $15, $1, $3  (se entrada > 5)
			RAM[25][26:18] = 15;
			RAM[25][17:9]  = 1; 
			RAM[25][8:0]   = 3;
		
			RAM[26][31:27] = 5'b10111; //out $15             (mostro a resposta do maiorQ)
			RAM[26][26:18] = 15; 
			RAM[26][17:0]  = 0;
			
			RAM[27][31:27] = 5'b01111; //MenorQ $16, $1, $3  (se entrada < 5)
			RAM[27][26:18] = 16;
			RAM[27][17:9]  = 1; 
			RAM[27][8:0]   = 3;
		
			RAM[28][31:27] = 5'b10111; //out $16             (mostro a resposta do menorQ)
			RAM[28][26:18] = 16; 
			RAM[28][17:0]  = 0;
			
			RAM[29][31:27] = 5'b01101; //Igual $17, $1, $3   (se entrada == 5)
			RAM[29][26:18] = 17;
			RAM[29][17:9]  = 1; 
			RAM[29][8:0]   = 3;
		
			RAM[30][31:27] = 5'b10111; //out $17             (mostro a resposta do igual)
			RAM[30][26:18] = 17; 
			RAM[30][17:0]  = 0;
			
			RAM[31][31:27] = 5'b10011; //jal $18, 33         (jump to 33 and link $18)
			RAM[31][26:18] = 18;
			RAM[31][17:9]  = 33; 
			RAM[31][8:0]   = 0;
			
			RAM[32][31:27] = 5'b10000; //nop
			RAM[32][26:0]  = 0; 
		
			RAM[33][31:27] = 5'b10111; //out $18              (mostro o jal)
			RAM[33][26:18] = 18; 
			RAM[33][17:0]  = 0;  */	
		
		   //Fibonacci
	/*   	RAM[0][31:27] = 5'b10000; //nop
			RAM[0][26:0]  = 0; 
				
			RAM[1][31:27] = 5'b10110; //in $1, input  (entrada)
			RAM[1][26:18] = 1; 
			RAM[1][17:0]  = 0;  
	
			RAM[2][31:27] = 5'b00101; //li $2, 1      (primeiro termo)
			RAM[2][26:18] = 2; 
			RAM[2][17:9]  = 1; 
			RAM[2][8:0]   = 0;
		
	      RAM[3][31:27] = 5'b00101; //li $3, 1      (segundo termo)
			RAM[3][26:18] = 3; 
			RAM[3][17:9]  = 1; 
			RAM[3][8:0]   = 0;
		
			RAM[4][31:27] = 5'b00101; //li $4, 2      (contador)
			RAM[4][26:18] = 4; 
			RAM[4][17:9]  = 2; 
			RAM[4][8:0]   = 0;
			
			RAM[5][31:27] = 5'b00101; //li $5, 1      (incremento)
			RAM[5][26:18] = 5; 
			RAM[5][17:9]  = 1; 
			RAM[5][8:0]   = 0;
			
			RAM[6][31:27] = 5'b00101; //li $6, 2      (aux contador)
			RAM[6][26:18] = 6; 
			RAM[6][17:9]  = 2; 
			RAM[6][8:0]   = 0;  
			
			RAM[7][31:27] = 5'b00000; //add $7, $2, $3  n = ((n-2) + (n-1))
			RAM[7][26:18] = 7;
			RAM[7][17:9]  = 2; 
			RAM[7][8:0]   = 3;  
			
			RAM[8][31:27] = 5'b00110; //str $3, [1]    (colocar o termo n-1 na memoria 1)
			RAM[8][26:18] = 3; 
			RAM[8][17:9]  = 1; 
			RAM[8][8:0]   = 0;
			
			RAM[9][31:27] = 5'b10001; //ld $2, [1]    (atualizar ele como o novo termo n-2)
			RAM[9][26:18] = 2; 
			RAM[9][17:9]  = 1; 
			RAM[9][8:0]   = 0;
			
			RAM[10][31:27] = 5'b00110; //str $7, [2]    (colocar o termo n na memoria 2)
			RAM[10][26:18] = 7; 
			RAM[10][17:9]  = 2; 
			RAM[10][8:0]   = 0;
			
			RAM[11][31:27] = 5'b10001; //ld $3, [2]    (atualizar ele como o novo termo n-1)
			RAM[11][26:18] = 3; 
			RAM[11][17:9]  = 2; 
			RAM[11][8:0]   = 0;
			
			RAM[12][31:27] = 5'b00000; //add $4, $6, $5  (contador = aux + 1)
			RAM[12][26:18] = 4;
			RAM[12][17:9]  = 6; 
			RAM[12][8:0]   = 5; 
			
			RAM[13][31:27] = 5'b00110; //str $4, [3]    (colocar o contador na memoria 3)
			RAM[13][26:18] = 4; 
			RAM[13][17:9]  = 3; 
			RAM[13][8:0]   = 0;
			
			RAM[14][31:27] = 5'b10001; //ld $6, [3]    (atualizar ele como o novo termo n-1)
			RAM[14][26:18] = 6; 
			RAM[14][17:9]  = 3; 
			RAM[14][8:0]   = 0;
			
			RAM[15][31:27] = 5'b10101; //beq 18, $1, $6  (termino se cheguei no termo)
			RAM[15][26:18] = 18; 
			RAM[15][17:9]  = 1; 
			RAM[15][8:0]   = 6;
			
			RAM[16][31:27] = 5'b10111; //out $7
			RAM[16][26:18] = 7; 
			RAM[16][17:0]  = 0; 
			
			RAM[17][31:27] = 5'b10010; //jump 7
			RAM[17][26:18] = 7; 
			RAM[17][17:0]  = 0;
			
			RAM[18][31:27] = 5'b10111; //out $7
			RAM[18][26:18] = 7; 
			RAM[18][17:0]  = 0; 
			
			RAM[19][31:27] = 5'b10010; //jump 18
			RAM[19][26:18] = 18; 
			RAM[19][17:0]  = 0;  */
			
			//Algoritmo testado na sala de aula			
			RAM[0][31:27] = 5'b00101; //li $1, 0             A=0
			RAM[0][26:18] = 1; 
			RAM[0][17:9]  = 0; 
			RAM[0][8:0]   = 0;
		
	      RAM[1][31:27] = 5'b00101; //li $2, 2             B=2
			RAM[1][26:18] = 2; 
			RAM[1][17:9]  = 2; 
			RAM[1][8:0]   = 0;
			
			RAM[2][31:27] = 5'b10101; //beq 10, $1, $2       se A == B
			RAM[2][26:18] = 10; 
			RAM[2][17:9]  = 1; 
			RAM[2][8:0]   = 2;
			
			RAM[3][31:27] = 5'b00000; //add $3, $1, $2          soma = A+B
			RAM[3][26:18] = 3;
			RAM[3][17:9]  = 1; 
			RAM[3][8:0]   = 2;
			
			RAM[4][31:27] = 5'b10111; //out $3
			RAM[4][26:18] = 3; 
			RAM[4][17:0]  = 0;
			
			RAM[5][31:27] = 5'b10110; //in $1, input         (entrada)
			RAM[5][26:18] = 1; 
			RAM[5][17:0]  = 0; 
		
			RAM[6][31:27] = 5'b10000; //nop
			RAM[6][26:0]  = 0;
			
			RAM[7][31:27] = 5'b10000; //nop
			RAM[7][26:0]  = 0;
			
			RAM[8][31:27] = 5'b10110; //in $2, input         (entrada)
			RAM[8][26:18] = 2; 
			RAM[8][17:0]  = 0; 
			
			RAM[9][31:27] = 5'b10010; //jump 2
			RAM[9][26:18] = 2; 
			RAM[9][17:0]  = 0;
			
			RAM[10][31:27] = 5'b10000; //nop
			RAM[10][26:0]  = 0;
			
			
			Ciclo <= 1;
			//Esta última mudança garante 1 vez por clock
		end
	end
	
	//Instrução
	assign Instrucao = RAM[Endereco];

endmodule

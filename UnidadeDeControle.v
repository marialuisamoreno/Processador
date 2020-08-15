/*Unidade de Controle do Processador*/

module UnidadeDeControle (opcode, controleULA, FlagMuxULA, FlagEscritaMemoria,
								  controleMuxMD, controleMuxBR, FlagEscritaReg, 
								  controleEnderecamento, controleSinal, controleDesvios,
								  BreakFlag, FlagJumpReg, NopFlag, PrintFlag, FlagLoad,
								  FlagULA, flagsaida);
	//Opcode que irá decidir qual instrução executar
	input [4:0] opcode;
	//Flag que irá indicar qual operação da ULA executar
	output reg [3:0] controleULA;
	//Flags auxiliares de 2 bits do Processador
	output reg [1:0] controleDesvios, controleEnderecamento, FlagMuxULA;
	//Flags auxiliares de 1 bit do Processador
	output reg BreakFlag, FlagEscritaMemoria, controleMuxMD,
				  controleMuxBR, NopFlag, FlagEscritaReg, FlagJumpReg, controleSinal,
				  PrintFlag, FlagLoad, FlagULA, flagsaida;

	always @ (opcode) 
	begin
		
		BreakFlag = 0;
		NopFlag = 0;
		controleEnderecamento = 0;
		FlagEscritaReg = 0;
		FlagJumpReg = 0;
		controleSinal = 0;
		FlagMuxULA = 0;
		controleULA = 0;
		controleDesvios = 0;
		FlagEscritaMemoria = 0;
		controleMuxMD = 0;
		controleMuxBR = 0;	
		PrintFlag = 0;
		FlagLoad = 0;
		FlagULA = 0;
		flagsaida = 0;
	
		case (opcode)
			//Instrução de SOMA                        ok                   
			5'b00000:
				begin
					BreakFlag = 0;
					NopFlag = 0;
					controleEnderecamento = 2'b10;
					FlagEscritaReg = 0;
					FlagJumpReg = 0;
					controleSinal = 1'bx;
					FlagMuxULA = 2'b10;
					controleULA = 4'b0000;
					FlagULA = 1;
					controleDesvios = 2'b00;
					FlagEscritaMemoria = 1'bx;
					controleMuxMD = 1;
					controleMuxBR = 0;
				end
			//Instrução de SUBTRAÇÃO                   ok          
			5'b00001:
				begin
					BreakFlag = 0;
					NopFlag = 0;
					controleEnderecamento = 2'b10;
					FlagEscritaReg = 0;
					FlagJumpReg = 0;
					controleSinal = 1'bx;
					FlagMuxULA = 2'b10;
					controleULA = 4'b0001;
					FlagULA = 1;
					controleDesvios = 2'b00;
					FlagEscritaMemoria = 1'bx;
					controleMuxMD = 1;
					controleMuxBR = 0;
				end
			//Instrução de MULTIPLICAÇÃO               ok      
			5'b00010:
				begin
					BreakFlag = 0;
					NopFlag = 0;
					controleEnderecamento = 2'b10;
					FlagEscritaReg = 0;
					FlagJumpReg = 0;
					controleSinal = 1'bx;
					FlagMuxULA = 2'b10;
					controleULA = 4'b0010;
					FlagULA = 1;
					controleDesvios = 2'b00;
					FlagEscritaMemoria = 1'bx;
					controleMuxMD = 1;
					controleMuxBR = 0;	
				end
			//Instrução de DIVISÃO                     ok   
			5'b00011:
				begin
					BreakFlag = 0;
					NopFlag = 0;
					controleEnderecamento = 2'b10;
					FlagEscritaReg = 0;
					FlagJumpReg = 0;
					controleSinal = 1'bx;
					FlagMuxULA = 2'b10;
					controleULA = 4'b0011;
					FlagULA = 1;
					controleDesvios = 2'b00;
					FlagEscritaMemoria = 1'bx;
					controleMuxMD = 1;
					controleMuxBR = 0;	
				end
			//Instrução de RESTO DA DIVISÃO            ok  
			5'b00100:
				begin
					BreakFlag = 0;
					NopFlag = 0;
					controleEnderecamento = 2'b10;
					FlagEscritaReg = 0;
					FlagJumpReg = 0;
					controleSinal = 1'bx;
					FlagMuxULA = 2'b10;
					controleULA = 4'b0100;
					FlagULA = 1;
					controleDesvios = 2'b00;
					FlagEscritaMemoria = 1'bx;
					controleMuxMD = 1;
					controleMuxBR = 0;	
				end
			//Instrução de LOAD IMEDIATO               ok     
			5'b00101:
				begin
					BreakFlag = 0;
					NopFlag = 0;
					controleEnderecamento = 2'b11;
					FlagEscritaReg = 1;
					FlagJumpReg = 0;
					controleSinal = 1;
					FlagMuxULA = 2'b00;
					controleULA = 4'b1110;
					controleDesvios = 2'b00;
					FlagEscritaMemoria = 1'bx;
					controleMuxMD = 1'bx;
					controleMuxBR = 1'bx;
				end
			//Instrução de STORE REG TO MEM            ok    str  $reg, [mem]
			5'b00110:
				begin
					BreakFlag = 0;
					NopFlag = 0;
					controleEnderecamento = 2'b11;
					FlagEscritaReg = 0;
					FlagJumpReg = 0;
					controleSinal = 1;
					FlagMuxULA = 2'b00;
					controleULA = 4'b1110;
					controleDesvios = 2'b00;
					FlagEscritaMemoria = 1;
					controleMuxMD = 1'bx;
					controleMuxBR = 1'bx;
				end
			//Instrução de E                           ok                       
			5'b00111:
				begin
					BreakFlag = 0;
					NopFlag = 0;
					controleEnderecamento = 2'b10;
					FlagEscritaReg = 0;
					FlagJumpReg = 0;
					controleSinal = 1'bx;
					FlagMuxULA = 2'b10;
					controleULA = 4'b0101;
					FlagULA = 1;
					controleDesvios = 2'b00;
					FlagEscritaMemoria = 1'bx;
					controleMuxMD = 1;
					controleMuxBR = 0;
				end
			//Instrução de OU                          ok
			5'b01000:
				begin
					BreakFlag = 0;
					NopFlag = 0;
					controleEnderecamento = 2'b10;
					FlagEscritaReg = 0;
					FlagJumpReg = 0;
					controleSinal = 1'bx;
					FlagMuxULA = 2'b10;
					controleULA = 4'b0110;
					FlagULA = 1;
					controleDesvios = 2'b00;
					FlagEscritaMemoria = 1'bx;
					controleMuxMD = 1;
					controleMuxBR = 0;
				end
			//Instrução de OU EXCLUSIVO                ok
			5'b01001:
				begin
					BreakFlag = 0;
					NopFlag = 0;
					controleEnderecamento = 2'b10;
					FlagEscritaReg = 0;
					FlagJumpReg = 0;
					controleSinal = 1'bx;
					FlagMuxULA = 2'b10;
					controleULA = 4'b1000;
					FlagULA = 1;
					controleDesvios = 2'b00;
					FlagEscritaMemoria = 1'bx;
					controleMuxMD = 1;
					controleMuxBR = 0;
				end
			//Instrução de NÃO                         ok
			5'b01010:
				begin
					BreakFlag = 0;
					NopFlag = 0;
					controleEnderecamento = 2'b10;
					FlagEscritaReg = 0;
					FlagJumpReg = 0;
					controleSinal = 1'bx;
					FlagMuxULA = 2'b10;
					controleULA = 4'b0111;
					FlagULA = 1;
					controleDesvios = 2'b00;
					FlagEscritaMemoria = 1'bx;
					controleMuxMD = 1;
					controleMuxBR = 0;
				end
			//Instrução de ROTAÇÃO DIREITA             ok
			5'b01011:
				begin
					BreakFlag = 0;
					NopFlag = 0;
					controleEnderecamento = 2'b10;
					FlagEscritaReg = 0;
					FlagJumpReg = 0;
					controleSinal = 1'bx;
					FlagMuxULA = 2'b10;
					controleULA = 4'b1001;
					FlagULA = 1;
					controleDesvios = 2'b00;
					FlagEscritaMemoria = 1'bx;
					controleMuxMD = 1;
					controleMuxBR = 0;
				end
			//Instrução de ROTAÇÃO ESQUERDA            ok
			5'b01100:
				begin
					BreakFlag = 0;
					NopFlag = 0;
					controleEnderecamento = 2'b10;
					FlagEscritaReg = 0;
					FlagJumpReg = 0;
					controleSinal = 1'bx;
					FlagMuxULA = 2'b10;
					controleULA = 4'b1010;
					FlagULA = 1;
					controleDesvios = 2'b00;
					FlagEscritaMemoria = 1'bx;
					controleMuxMD = 1;
					controleMuxBR = 0;
				end	
			//Instrução de IGUAL                       ok
			5'b01101:
				begin
					BreakFlag = 0;
					NopFlag = 0;
					controleEnderecamento = 2'b10;
					FlagEscritaReg = 0;
					FlagJumpReg = 0;
					controleSinal = 1'bx;
					FlagMuxULA = 2'b10;
					controleULA = 4'b1011;
					FlagULA = 1;
					controleDesvios = 2'b00;
					FlagEscritaMemoria = 1'bx;
					controleMuxMD = 1;
					controleMuxBR = 0;
				end
			//Instrução de MAIOR QUE                   ok
			5'b01110:
				begin
					BreakFlag = 0;
					NopFlag = 0;
					controleEnderecamento = 2'b10;
					FlagEscritaReg = 0;
					FlagJumpReg = 0;
					controleSinal = 1'bx;
					FlagMuxULA = 2'b10;
					controleULA = 4'b1100;
					FlagULA = 1;
					controleDesvios = 2'b00;
					FlagEscritaMemoria = 1'bx;
					controleMuxMD = 1;
					controleMuxBR = 0;
				end
			//Instrução de MENOR QUE                   ok
			5'b01111:
				begin
					BreakFlag = 0;
					NopFlag = 0;
					controleEnderecamento = 2'b10;
					FlagEscritaReg = 0;
					FlagJumpReg = 0;
					controleSinal = 1'bx;
					FlagMuxULA = 2'b10;
					controleULA = 4'b1101;
					FlagULA = 1;
					controleDesvios = 2'b00;
					FlagEscritaMemoria = 1'bx;
					controleMuxMD = 1;
					controleMuxBR = 0;
				end
			//Instrução de SEM OPERAÇÃO                ok
			5'b10000:
				begin
					BreakFlag = 0;
					NopFlag = 1;
					controleEnderecamento = 2'b10;
					FlagEscritaReg = 0;
					FlagJumpReg = 0;
					controleSinal = 1'bx;
					FlagMuxULA = 2'bxx;
					controleULA = 4'bxxxx;
					controleDesvios = 2'b00;
					FlagEscritaMemoria = 1'bx;
					controleMuxMD = 1'bx;
					controleMuxBR = 1'bx;
				end
			//Instrução de LOAD MEM TO REG             ok     ld  $reg, [mem]
			5'b10001:
				begin
					BreakFlag = 1'b0;
					NopFlag = 1'b0;
					controleEnderecamento = 2'b11;  //rc e rb
					FlagEscritaReg = 1'b0;     //ok             
		         FlagLoad = 1'b1;           //ok              
					FlagJumpReg = 1'b0;        //ok
					controleSinal = 1'b1;      //ok
					FlagMuxULA = 2'b00;        //ok
					controleULA = 4'b1110;     //ok
					FlagULA = 1'b0;            //ok
					controleDesvios = 2'b00;   //ok
					FlagEscritaMemoria = 1'b0; //ok
					controleMuxMD = 1'bx;  //ok
					controleMuxBR = 1'bx;  //ok
				end
			//Instrução de JUMP                        ok
			5'b10010:
				begin
					BreakFlag = 0;
					NopFlag = 0;
					controleEnderecamento = 2'b01;
					FlagEscritaReg = 0;
					FlagJumpReg = 0;
					controleSinal = 0;
					FlagMuxULA = 2'b00;
					controleULA = 4'b1110;
					controleDesvios = 2'b10;
					FlagEscritaMemoria = 0;
					controleMuxMD = 1'bx;
					controleMuxBR = 1'bx;
				end
			//Instrução de JUMP AND LINK               ok
			5'b10011:
				begin
					BreakFlag = 0;
					NopFlag = 0;
					controleEnderecamento = 2'b11;
					FlagEscritaReg = 0;
					FlagJumpReg = 1;
					controleSinal = 0;
					FlagMuxULA = 2'b00;
					controleULA = 4'b1110;
					controleDesvios = 2'b10;
					FlagEscritaMemoria = 0;
					controleMuxMD = 1'bx;
					controleMuxBR = 1'bx;
				end	
			//Instrução de BREAK                       ?
			5'b10100:
				begin
					BreakFlag = 1;
					NopFlag = 0;
					controleEnderecamento = 2'b01;
					FlagEscritaReg = 0;
					FlagJumpReg = 0;
					controleSinal = 0;
					FlagMuxULA = 2'b00;
					controleULA = 4'b1110;
					controleDesvios = 2'b10;
					FlagEscritaMemoria = 0;
					controleMuxMD = 1'bx;
					controleMuxBR = 1'bx;
				end	
			//Instrução de BRANCH ON EQUAL             ok
			5'b10101:
				begin
					BreakFlag = 0;
					NopFlag = 0;
					controleEnderecamento = 2'b10;
					FlagEscritaReg = 0;
					FlagJumpReg = 0;
					controleSinal = 1'bx;
					FlagMuxULA = 2'b10;
					controleULA = 4'b1011;
					controleDesvios = 2'b01;
					FlagEscritaMemoria = 1'bx;
					controleMuxMD = 1'bx;
					controleMuxBR = 1'bx;
				end
			//Instrução de ENTRADA                     ok
			5'b10110:
				begin
					BreakFlag = 0;
					NopFlag = 0;
					controleEnderecamento = 2'b11;
					FlagEscritaReg = 0;
					FlagJumpReg = 0;
					controleSinal = 0;
					FlagMuxULA = 2'bxx;
					controleULA = 4'bxxxx;
					FlagULA = 1;
					controleDesvios = 2'b00;
					FlagEscritaMemoria = 1'bx;
					controleMuxMD = 1'bx;
					controleMuxBR = 1;
					PrintFlag = 1;
				end 
			//Instrução de SAIDA                       ok
			5'b10111: 
				begin
					BreakFlag = 0;
					NopFlag = 0;
					controleEnderecamento = 2'b01;
					FlagEscritaReg = 0;
					FlagJumpReg = 0;
					controleSinal = 1'bx;
					FlagMuxULA = 2'b10;
					controleULA = 4'b1110;
					controleDesvios = 2'b00;
					FlagEscritaMemoria = 0;
					controleMuxMD = 1'bx;
					controleMuxBR = 1'bx;
					flagsaida = 1;
				end
			//Default - NOP                            ok
			default:	
				begin
					BreakFlag = 0;
					NopFlag = 1;
					controleEnderecamento = 2'b10;
					FlagEscritaReg = 0;
					FlagJumpReg = 0;
					controleSinal = 1'bx;
					FlagMuxULA = 2'bxx;
					controleULA = 4'bxxxx;
					controleDesvios = 2'b00;
					FlagEscritaMemoria = 1'bx;
					controleMuxMD = 1'bx;
					controleMuxBR = 1'bx;
				end
		endcase
	end
endmodule


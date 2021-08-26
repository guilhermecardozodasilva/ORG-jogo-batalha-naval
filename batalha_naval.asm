 	.data
matriz: 		.space 400					#tamanho total da matriz (10x10x4=400)
navios:			.asciz	"3\n1 5 1 1\n0 5 2 2\n0 1 6 4" 		#string para inser��o dos navios
numeros:		.asciz	"0123456789"
msg_quebra_linha:	.asciz "\n"
msg_espaco:		.asciz " "

	.text
main: 
	la	s0, matriz			# endere�o inicial da matriz carregada em s0
	la	s1, navios			# endere�o inicial da string navios carregada em s1
	la	s2, numeros			# endere�o inicial da string numeros carregada em s2
	lw	t0, (s0)			# carrega o primeiro valor da matriz s0 em t0 
	lb	t1, (s1)			# carrega a primeira letra da string navios s1 em t1
	lb	t2, (s2)			# carrega o primeiro n�mero da string navios s2 em t2 
	addi	a1, a1, 100			# tamanho total da matriz
	addi	a2, zero, 0			# auxiliar para o for 
	addi	a3, zero, 0			# auxiliar para o for 
	addi	a4, zero, 10			# auxiliar para imprimir a matriz e quebrar linha
	addi	a5, zero, 0			# auxilar para saber qual n�mero da string navios
	addi	a6, zero, 8			# valor de cada navio na string navios
	addi	a7, zero, 2			# valor para saber se o navios ser� inserido na vertical ou horizontal
	addi	s4, zero, 4			# valor para saber o tamanho do  navio que ser� inserido
	addi	s5, zero, 0			# registrador respons�vel por armazenar o tamanho do navio que ser� inserido
	addi	s6, zero, 6			# valor para saber a linha que o navio ser� inserido
	addi	s7, zero, 0			# registrador respons�vel por armazenar a linha que o navio que ser� inserido
	addi	s8, zero, 8			# valor para saber a coluna que o navio ser� inserido
	addi	s9, zero, 0			# registrador respons�vel por armazenar a linha que o navio que ser� inserido
	addi	s10, zero, 0			# registrador para o loop 
	addi	t3, zero, 1			# valores das embarcacoes
	addi	t4, zero, 0
	jal	zera_matriz			# preenche toda matriz com zero.
			
	
zera_matriz:
	beq 	a2, a1, qnt_embarcacoes		# se a2 (0) = a1 (100), acaba o la�o de repeti��o. 
	sw	zero, (s0)			# preenche com o valor zero a matriz
	addi	s0, s0, 4			# vai para a pr�xima posi��o da matriz
	addi	a2, a2, 1			# incremento de um no registrador a2	
	j	zera_matriz			# continua o la�o de repeti��o
	
insere_embarcacoes:
	la	s2, numeros			# endere�o inicial da string numeros carregada em s2	
	lb	t2, (s2)			# carrega o primeiro n�mero da string navios s2 em t2 
	beq	a2, a5, imprime_matriz 		# verifica se inseriu todos os navios a2(0) = a5 (qnt_navios)
	beq	a3, a6, coluna_navio		# se a3 (0) = a6 (8)
	beq	a3, a7, orientacao_navio	# se a3 = a7 (2). Significa que estamos pegando o n�mero da orienta��o do navio
	beq	a3, s4, tamanho_navio		# se a3 = s4 (4). Significa que estamos pegando o tamanho do navio que ser� inserido
	beq	a3, s6, linha_navio		# se a3 = s6 (6). Significa que estamos pegando a linha que o navio ser� inserido
	#beq	a3, s8, coluna_navio		# se a3 = s8 (8). Significa que estamos pegando a coluna que o navio ser� inserido
	addi	s1, s1, 2			# vai para o pr�ximo n�mero da string navios. Pula de 2 em 2 para pular os espa��es e \n 
	lb	t1, (s1)			# atualiza valor de t1
	addi	a3, a3, 2
	j	insere_embarcacoes
	
prox_navio:
	addi	a2, a2, 1			# incrementa de 2 em 2
	mul	s11, s7, a4			# S11 (POSIC�O INICIAL NAVIO) = S7 (LINHA) * A4 (10 QNT COLUNA)	 
	add	s11, s11, s9			# S11 (POSIC�O INICIAL NAVIO) = S11 + S9 (COLUNA)
	mul	s11, s11, s4			# S11 (POSIC�O INICIAL NAVIO) = s11 * s4 (4)
	la	s0, matriz			# endere�o inicial da matriz carregada em s0
	add	s0, s0, s11			# adiciona a posi��o inicial do vetor com s11 (posi��o que o navio ser� inserido)
	j	insere_navio
	
insere_navio:
	beq  	s10, s5, atualiza_registradores	# se s10 (0) = s5 (tamanho navio)
	beq  	s3, zero, insere_horizontal
	sw	t3, (s0)			# salva o valor da embarcac�o na posi��o vertical
	addi	s0, s0, 40			# incrementa o s0 em 1 e vai para a pr�xima posi��o vertical do navio
	addi	s10, s10, 1 			# incrementa o s10 em 1
	j	insere_navio

insere_horizontal:
	sw	t3, (s0)			# salva o valor da embarcac�o na posi��o
	addi	s0, s0, 4			# incrementa o s0 em 1 e vai para a pr�xima posi��o horizontal do navio
	addi	s10, s10, 1 			# incrementa o s10 em 1
	j	insere_navio
	
atualiza_registradores:
	addi	a3, zero, 0			# atualiza o valor de a3 para zero
	addi	s10, zero, 0			# atualiza o aux do for que comapar o tamanho do vetor
	addi	s5, zero, 0			# atualiza o valor de s5 (tamanho navio) para zero
	addi	s7, zero, 0 			# atualiza o valor de s7 (linha do navio) para zero
	addi	s9, zero, 0 			# atualiza o valor de s7 (coluna do navio) para zero
	addi	t3, t3, 1			# add 1 no registrador t3 (responsavel pelo numero do navio)
	la	s0, matriz			# endere�o inicial da matriz carregada em s0
	j	insere_embarcacoes
	
orientacao_navio:
	beq	t1, t2, navio_horizontal	# se t1(valor 1 ou 0) = t2 (0)
	addi	s3, zero, 1			# s3 � respons�vel por armazenar a orienta��o do navio (vertical ou horizontal)
	addi	s1, s1, 2			# vai para o pr�ximo n�mero da string navios. Pula de 2 em 2 para pular os espa��es e \n 
	lb	t1, (s1)			# atualiza valor de t1
	addi	a3, a3, 2
	j	insere_embarcacoes
	
navio_horizontal:
	addi	s3, zero, 0			# s3 � respons�vel por armazenar a orienta��o do navio (vertical ou horizontal)	
	addi	s1, s1, 2			# vai para o pr�ximo n�mero da string navios. Pula de 2 em 2 para pular os espa��es e \n 
	lb	t1, (s1)			# atualiza valor de t1
	addi	a3, a3, 2
	j	insere_embarcacoes

tamanho_navio:
	beq	t1, t2, atualiza_valores
	addi	s2, s2, 1			# vai para o pr�ximo n�mero da string n�meros
	lb	t2, (s2)			# carrega n�mero da string navios s2 em t2
	addi	s5, s5, 1 			# registrador respons�vel por armazenar o tamanho do navio que ser� inserido
	j	tamanho_navio
	
linha_navio:
	beq	t1, t2, atualiza_valores
	addi	s2, s2, 1			# vai para o pr�ximo n�mero da string n�meros
	lb	t2, (s2)			# carrega n�mero da string navios s2 em t2
	addi	s7, s7, 1 			# registrador respons�vel por armazenar a linha que o navio que ser� inserido
	j	linha_navio
	
coluna_navio:
	beq	t1, t2, prox_navio
	addi	s2, s2, 1			# vai para o pr�ximo n�mero da string n�meros
	lb	t2, (s2)			# carrega n�mero da string navios s2 em t2
	addi	s9, s9, 1 			# registrador respons�vel por armazenar a coluna que o navio que ser� inserido
	j	coluna_navio
	
atualiza_valores:
	addi	s1, s1, 2			# vai para o pr�ximo n�mero da string navios. Pula de 2 em 2 para pular os espa��es e \n 
	lb	t1, (s1)			# atualiza valor de t1
	addi	a3, a3, 2
	j	insere_embarcacoes
	
qnt_embarcacoes:
	addi	a2, zero, 0			# auxiliar para o for 
	beq	t1, t2, insere_embarcacoes
	addi	s2, s2, 1			# vai para o pr�ximo n�mero da string n�meros
	lb	t2, (s2)			# carrega n�mero da string navios s2 em t2
	addi	a5, a5, 1 			# registrador respons�vel por armazenar o valor da quantidade de navios que ser�o inseridos.
	j	qnt_embarcacoes
				
imprime_matriz:	
	beq 	t4, a1, end			# se a2 (0) = a1 (100), acaba o la�o de repeti��o. Inicialmente a2 = 0 e vai somando 1
	beq	a3, a4, quebra_linha 		# se a3 (0) = a4 (10), acaba o la�o e vai para a fun��o quebra_linha. Inicialmente o a3 = 0 e vai somando 1 
	lw 	s1, (s0)			# carrega o valor atual do vetorA s0 em s1 
	mv 	a0, s1  			# imprime inteiro
	li 	a7, 1		
	ecall	
	
	la 	a0, msg_espaco  		# imprime mensagem
	li 	a7,4
	ecall
	
	addi 	t4, t4,1			# incrementa o auxiliar do la�o
	addi 	a3, a3,1			# incrementa o auxiliar do la�o
	addi 	s0, s0, 4			# vai para a pr�xima posi��o do vetor
	j 	imprime_matriz	
	
quebra_linha:
	addi	a3, zero, 0			# zera o auxiliar a3 para continuar quebrando linha depois de 10 posi�oes
	
	la 	a0, msg_quebra_linha  		# imprime mensagem
	li 	a7,4
	ecall
	
	j	imprime_matriz
	
end:
	ecall		
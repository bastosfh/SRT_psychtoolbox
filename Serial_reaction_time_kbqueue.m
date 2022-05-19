%cd '/home/flavio/Documents/Dropbox/Scripts/Octave - scripts/Psychtoolbox/Serial_reaction_time';
cd '/home/coleta/Serial_reaction_time';
% Serial_reaction_time_kbqueue



%%%%%%%% Para desenvolvimento - notebook


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% Em que consiste a tarefa %%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%% configuracoes %%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Qual o nome do grupo experimental?
experimento = 'Delete';

% Numero do sujeito
sjnum = '1';

% Determina o número de tentativas
ntt = 2;

% Qual arquivo externo deve ser utilizado como referência para essa sessão de prática?
arquivo_ext = 'fix.txt';



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%% enderecos fisicos %%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%% Para desenvolvimento (notebook):

%% Determina o intervalo entre estímulos (em segundos)
%script_path = '/home/flavio/Documents/Dropbox/Scripts/Octave - scripts/Psychtoolbox/Serial_reaction_time';

%txt_name = sprintf('%s_suj%s.txt', experimento, sjnum); %nome do arquivo txt para salvar todas as tentativas do sujeito

%mkdir(experimento); % Criar uma pasta para armazenar os arquivos deste experimento

%% Lê o arquivo externo contendo as combinações de estímulos
%colour_combinations_path = '/home/flavio/Documents/Dropbox/Scripts/Octave - scripts/Psychtoolbox/Serial_reaction_time/Colour_combinations.txt';
%colour_combinations_all = dlmread(colour_combinations_path);

%% Lê o arquivo externo contendo os tempo entre o alerta e o estímulo imperativo
%warning_imperative_intervals = dlmread('/home/flavio/Documents/Dropbox/Scripts/Octave - scripts/Psychtoolbox/Serial_reaction_time/warning_imperative_intervals.txt');





% Determina o intervalo entre estímulos (em segundos)
script_path = '/home/coleta/Serial_reaction_time';

txt_name = sprintf('%s_suj%s.txt', experimento, sjnum); %nome do arquivo txt para salvar todas as tentativas do sujeito

mkdir(experimento); % Criar uma pasta para armazenar os arquivos deste experimento

% Lê o arquivo externo contendo as combinações de estímulos

colour_combinations_path = sprintf('/home/coleta/Serial_reaction_time/%s', arquivo_ext);

%colour_combinations_path = '/home/coleta/Serial_reaction_time/Colour_combinations.txt';
colour_combinations_all = dlmread(colour_combinations_path, '\t', [0 0 8 35]); % [linha_inicial coluna_inicial linha_final coluna_final] % O primeiro índice é igual a 0 (ex.: coluna 1 = 0)

% Lê o arquivo externo contendo os tempo entre o alerta e o estímulo imperativo
warning_imperative_intervals = dlmread('/home/coleta/Serial_reaction_time/warning_imperative_intervals.txt');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%% preparar a tela e as cores %%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Opens the active window
screenNum = 1;

% Modifica a resolução e a frequência do monitor (refresh rate)
% Antes de abrir a janela em que serão gerados os estímulos
%oldResolution = Screen('Resolution', screenNum, 1366, 768, 60);

% A solução comentada acima não dá conta da configuração com dois monitores. Esta abaixo, sim.
oldResolution = Screen('ConfigureDisplay', setting = 'Scanout', screenNumber = screenNum, outputId = 0, newwidth = 1680, newheight = 1050, newHz = 120);
[wPtr,rect] = Screen('OpenWindow', screenNum); % Using screen number only, the whole screen is used as default

% Color parameters MUST came after openning the window
black = BlackIndex(wPtr);
white = WhiteIndex(wPtr);
red = [255 0 0];
green = [0 255 0];
yellow = [255 255 0];

% Fills the open window with black
Screen('FillRect',wPtr,black);
Screen('Flip', wPtr); % Flip
HideCursor;
WaitSecs(0.1); % Waits a specified time (in seconds)

% Adquire a frequencia do monitor para calcular o tempo entre tentativas
[ monitorFlipInterval nrValidSamples stddev ] = Screen('GetFlipInterval', wPtr);
% Put functions into memory for speed
GetSecs;
WaitSecs(0.1);
[keyIsDown, secs, keyCode, deltaSecs] = KbCheck;
keyPressed = KbName(keyCode); % Armazena a tecla pressionada
keyPressed = [];


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% alvos e cursores para a pratica %%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Target size
size_horiz = rect(RectRight)/20;
size_vert = size_horiz;

% Cursor size
cursor_horiz = rect(RectRight)/35;
cursor_vert = cursor_horiz;

% Distance between cursors
cursor_dist_h = rect(RectRight)/6 + (cursor_horiz/6);
cursor_dist_v = cursor_dist_h;

% Target 1 coordinates
x_esq1 = rect(RectRight)/4 - (cursor_horiz/2);
x_dir1 = x_esq1 + size_horiz;
y_esq1 = rect(RectBottom)/2;
y_dir1 = y_esq1 + size_vert;

% Target 2 coordinates
x_esq2 = rect(RectRight)/4 - (cursor_horiz/2) + cursor_dist_h;
x_dir2 = x_esq2 + size_horiz;
y_esq2 = rect(RectBottom)/2;
y_dir2 = y_esq2 + size_vert;

% Target 3 coordinates
x_esq3 = rect(RectRight)/4 - (cursor_horiz/2) + cursor_dist_h*2;
x_dir3 = x_esq3 + size_horiz;
y_esq3 = rect(RectBottom)/2;
y_dir3 = y_esq3 + size_vert;

% Target 4 coordinates
x_esq4 = rect(RectRight)/4 - (cursor_horiz/2) + cursor_dist_h*3;
x_dir4 = x_esq4 + size_horiz;
y_esq4 = rect(RectBottom)/2;
y_dir4 = y_esq4 + size_vert;

% Cor inicial dos alvos (warning signal)
alvo_color_ini = red;






% Determina a coluna do arquivo externo de onde será "lida" a combinação de estímulos para a primeira tentativa da fase experimental em curso
stim_col = 1;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% Loop de tentativas %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
trial = 0;
for i = 1:ntt
	
	trial = trial + 1;
	
	
	
	
	
	
	% Se for a primeira tentativa, aguarda o Enter do participante para iniciar
	if trial == 1
		WaitSecs(0.5);
		Screen('TextSize',wPtr, 40);
		Screen('DrawText', wPtr, 'Pressione 0 para iniciar', 300, 300, [255, 255, 255]);
		
		%[start_trial1_time, keyCode, deltaSecs] = KbWait; % Aguarda o enter para iniciar a tentativa
		
		
		
		Screen('Flip', wPtr); % Flip

		
		
		
		keyIsDown = 0;
		while keyIsDown == 0
			[keyIsDown, secs, keyCode, deltaSecs] = KbCheck;
			key_pressed_to_start = KbName(keyCode); % Get key correponding to the keyboard code
		
			% Check if multiple keys were pressed
			% Or if the key pressed is different from 1 and 2
			if length(key_pressed_to_start) > 1
				keyIsDown = 0;
				%fb_choice = 0;
			end
			
			if ~isequal (key_pressed_to_start, '0') % Just in case...
				keyIsDown = 0;
			end
		
		end		
		
		
		
		
		
		
		
		
		
	end
			
		
		
		
		
	
	
	
	
	
	
	
	
	
	
	% Após a primeira tentativa, indica (a coluna % lida do arquivo externo % com) a combinação de estímulos e as referências para respostas para a próxima tentativa
	if trial > 1
		stim_col = stim_col + 2;
	end
	
	
	% Seleciona somente as colunas do arquivo externo que serão utilizas na tentativa corrente
	colour_combinations_trial = colour_combinations_all(:, stim_col:(stim_col + 1));

	
	% Restringe o escaneamento do teclado a somente as teclas de interesse
	% O uso de KbQueue ao invés do KbCheck permite obter com maior precisão a quantidade de teclas pressinadas
	% E o tempo de pressionamento (no caso de múltiplas respostas, como nesta tarefa).
	keysOfInterest=zeros(1,256);
	keysOfInterest(KbName({'1', '2', '3', '4'}))=1;
	KbQueueCreate(-1, keysOfInterest);
	KbQueueStart;
	
	
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%%%%%%%%%%%%% Pré-Animação %%%%%%%%%%%%
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	
	% Desenha o sinal de alerta (warning signal): todos os alvos aparecem "apagados"
	Screen('FillRect', wPtr, alvo_color_ini, [x_esq1 y_esq1 x_dir1 y_dir1]);
	Screen('FillRect', wPtr, alvo_color_ini, [x_esq2 y_esq2 x_dir2 y_dir2]);
	Screen('FillRect', wPtr, alvo_color_ini, [x_esq3 y_esq3 x_dir3 y_dir3]);
	Screen('FillRect', wPtr, alvo_color_ini, [x_esq4 y_esq4 x_dir4 y_dir4]);
	
	Screen('Flip', wPtr); % Flip
	
	% Espera o tempo lido do arquivo externo (warning_imperative_intervals)
	WaitSecs(warning_imperative_intervals(trial));
	
	keyIsDown = 0;
	response = [];
	
	% Essa variável deve estar dentro do loop de animação para que haja mudança na combinação de estímulos
	next_stim = 1;
	
	% Conta os pressionamentos de tecla que não correspondem ao estímulo
	pressed_key_all = [];
	
	% Variáveis para medir tempo dentro do loop
	%time_response_all = [];
	pressed_key_time_all = [];
	
	
	% Registra o momento em que o primeiro estímulo foi apresentado
	time_ini = GetSecs;
	
	
	
	
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%%%%%%%%%%%%%%% Animação %%%%%%%%%%%%%%
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	while next_stim <= size(colour_combinations_trial, 1)

		
		% Seleciona somente as combinações para o próximo estímulo
		colour_combinations = colour_combinations_trial(next_stim,:);
		
		% Traduz a combinação de estímulos (em 0 e 1 no arquivo externo) para códigos RGB
		if colour_combinations(1) == 2111
			alvo_colors = [green red red red];
			
			elseif colour_combinations(1) == 1211
			alvo_colors = [red green red red];
			
			elseif colour_combinations(1) == 1121
			alvo_colors = [red red green red];
			
			elseif colour_combinations(1) == 1112
			alvo_colors = [red red red green];
			
		end
		

		
		[pressed, firstPress] = KbQueueCheck; % Recupera os pressionamentos de tecla desde que KbQueueStart foi executado
		if pressed
			pressedCodes = find(firstPress); % Encontra o momento em que o pressionamento da tecla foi iniciado
			
			
			pressed_key = KbName(pressedCodes(1)); % Encontra a tecla correspondente ao código registrado
			pressed_key_all = [pressed_key_all str2num(pressed_key)]; % Acumula todas as teclas que forem pressionadas ao longo da tentativa

			% Registra o momento em que a tecla foi pressionada, caso ela corresponda à resposta esperada para o estímulo apresentado
			if pressed_key == num2str(colour_combinations(2))
								
				pressed_key_time = firstPress(pressedCodes(1)) - time_ini;
				pressed_key_time_all = [pressed_key_time_all pressed_key_time]; % Acumula o momento em que cada tecla foi pressionada, tendo como referência o início da tentativa
				
				% "Apaga" o estímulo pressionado por 8ms (tempo de um flip em 120Hz)				
				alvo_colors = [red red red red];
								
				pressed = [];
				next_stim = next_stim + 1; % Se a resposta foi correta, sinaliza o início do próximo estímulo
			end
		
		
		end
		
		
		%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		% Desenha os alvos de acordo com as combinações %
		%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		% Draws targets
		Screen('FillRect', wPtr, alvo_colors(1:3), [x_esq1 y_esq1 x_dir1 y_dir1]);
		Screen('FillRect', wPtr, alvo_colors(4:6), [x_esq2 y_esq2 x_dir2 y_dir2]);
		Screen('FillRect', wPtr, alvo_colors(7:9), [x_esq3 y_esq3 x_dir3 y_dir3]);
		Screen('FillRect', wPtr, alvo_colors(10:12), [x_esq4 y_esq4 x_dir4 y_dir4]);
		
		
		Screen('Flip', wPtr); % Flip
		

	end
	
	
	
	%%%%%%%%%%%%
	% Feedback %
	%%%%%%%%%%%%
	
	WaitSecs(0.5); % Para que a tecla não esteja pressionada quando o feedback for apresentado na tela
	
	% Calcula o erro na quantidade de respostas e o tempo total necessário para realizar a sequência
	pressed_key_error = length(pressed_key_all) - size(colour_combinations_trial, 1);
	total_sq_time = pressed_key_time_all(end);
	
	% Transforma o feedback em texto para ser apresentado na tela
	pressed_key_error_fbtext = ['Número de erros na sequência: ' num2str(pressed_key_error)];
	total_sq_time_fb_text = ['Tempo total: ' num2str(round(total_sq_time*1000)) ' ms'];
	
	Screen('TextSize',wPtr, 40);
	Screen('DrawText', wPtr, pressed_key_error_fbtext, rect(RectRight)/10, rect(RectBottom)/4, [255, 255, 255]);
	Screen('DrawText', wPtr, total_sq_time_fb_text, rect(RectRight)/10, rect(RectBottom)/3, [255, 255, 255]);
	Screen('DrawText', wPtr, 'Pressione 0 para iniciar a próxima tentativa', rect(RectRight)/5, rect(RectBottom)/1.5, [255, 255, 255]);

	
	Screen('Flip', wPtr);
	
	% Calcula o tempo observando o feedback na tela
	fb_time_ini = GetSecs;
	%[fb_time_end, keyCode, deltaSecs] = KbWait; % Aguarda o enter para passar à próxima tentativa
	
	
	
	
	
	
	
	
	keyIsDown = 0;
	while keyIsDown == 0
		[keyIsDown, secs, keyCode, deltaSecs] = KbCheck;
		key_pressed_to_start = KbName(keyCode); % Get key correponding to the keyboard code
		
		% Check if multiple keys were pressed
		% Or if the key pressed is different from 1 and 2
		if length(key_pressed_to_start) > 1
			keyIsDown = 0;
			%fb_choice = 0;
		end
			
		if ~isequal (key_pressed_to_start, '0') % Just in case...
			keyIsDown = 0;
		end
		
		
	end	
	
	% Get time when 0 is pressed
	fb_time_end = GetSecs;	
	
	fb_time = fb_time_end - fb_time_ini;
	
	
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%%%%%%%%%% Salva os dados adquiridos %%%%%%%%%%
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	
	dados_tentativa = [trial size(colour_combinations_trial, 1) pressed_key_error total_sq_time fb_time];
	
	cd(experimento); % Muda para a pasta do experimento sendo conduzido
    dlmwrite(txt_name, dados_tentativa, 'delimiter', '\t', '-append');
    cd(script_path); % Retorna para a pasta onde esta o script
    WaitSecs(0.5); % Evita que a tecla esteja pressionada no incio da proxima tentativa
    
	
	% Encerrar o KbQueue (liberar memória)
	KbQueueRelease;

% Fecha o loop de tentativas
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%% agradecimento %%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if (trial - ntt) == 0
	WaitSecs(0.2);
	Screen('TextSize',wPtr, 40);
	Screen('DrawText', wPtr, 'OBRIGADO!', 300, 300, [255, 255, 255]);
	Screen('Flip', wPtr);
	[end_experiment_time, keyCode, deltaSecs] = KbWait; % Aguarda o enter para encerrar o experimento
end

Screen('CloseAll');



%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%% Log %%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%

% 12/03/2018
% A tentativa é iniciada somente quando a tecla 0 é pressionada.
% Anteriormente, qualquer tecla poderia ser pressionada, ocassionando possíveis inícios
% Indesejados da tarefa.

% 18/12/2017
% Foi implementada uma mensagem ao participante antes da primeira tentativa (para que ele não seja prejudicado 
% Pela necessidade do pesquisador pressionar enter para iniciar).
% Uma mensagem "pressionar enter para iniciar a próxima tentativa" também foi incluída na tela de feedback.


% 15/12/2017
% O script faz as capturas utilizando kbqueue, o que faz com que as respostas sejam registradas de forma precisa.
% Foi implementado um sistema de gerenciamento de coleta que utiliza um arquivo externo para determinar as sequências de estímulos.
% O tamanho da sequência (número de respostas em série) é determinado pelo número de linhas no arquivo.
% Cada estímulo diz respeito a uma combinação de '1' e '2', sendo '2' o que indica o "acendimento" do estímulo.
% A combinação de cores (conjunto de estímulos vermelhos e um verde) é lida juntamente com a tecla que deve ser pressionada - o arquivo externo é organizado em pares de colunas.
% O número de tentativas determinado nas configurações não pode exceder o número de pares de colunas no arquivo externo (também indicado nas configurações).


      function sol = main()
        % Se deshabilitan las alertas %
        warning('off', 'all');
        pkg symbolic load;
        syms x;
        format long;
        solutions = [];
        biseccion_time = [];
        cpu_biseccion = [];
        newton_time = [];
        cpu_newton = [];
        time_fijo = [];
        cpu_fijo = [];
        total_time = [];
        % Matriz de parametros:                                                                %
        %                                    Ejemplo:                                          %
        %   ---------- ----------- ------------- ------------- ---- ------------- -----------  %
        %  | Ecuación | g(x) = x  | Intervalo 1 | Intervalo 2 | x0 | Iteraciones | Tolerancia| %
        %  | -------- | --------- | ----------- | ----------- | -- | ----------- | --------- | %
        %  | 2x^4     |           |     0.5     |      1      | -2 |     100     |   10^-4   | %
        %  | sin(x)   |           |     -2      |      0.5    | -1 |     200     |   10^-5   | %
        %  | e^(-x)   |           |      0      |      1      | 20 |     500     |   10^-6   | %
        %  | -------- | --------- | ----------- | ----------- | -- | ----------- | --------- | %

        m_parameters = [
                          (2*x^3)-x-1,(x+1)/2, 0.5, 1, 1, 500, 10^-5;
                          e^x - x^2,1/(2*sqrt(e^x)), -1, 1, 0, 10, 10^-5;
                          sin(x) - x^2,sqrt(sin(x)), 0.5, 1, -1, 100, 10^-5;
                          1/x - log(x),1/log(x), 1, 2, 20, 50, 10^-5;
                          0.5*sin(x)-x+1,0.5*sin(x)+1, 1, 2, 0, 200, 10^-5;
                          cos(x) - x,-sin(x), 0.5, 1, 100, 500, 10^-5;
                          2*x*cos(2*x)+(x-1)^2,(1/2)-(cos(2*x)/2) , -0.5, 1, -0.5, 10, 10^-5;
                          x^3 + 4*x^2-10,sqrt(10-x^3 / 4), 1, 2, 0, 500, 10^-5;
                          x^1/2 - log(x),log(x)^2, -0.5, 1, 5, 50, 10^-5;
                          tan(x) - x,sec(x)^2, -0.5, 1, 0, 100, 10^-5
                       ];
         index = 1;
         while (index == 1)
          %Se crea el menu para que el usuario escoja que algoritmo quiere usar%
          choice = menu('Que algoritmo quieres usar?', {'Bisección','NewtonRaphson','Punto fijo', 'Finalizar programa'});
          %Dependiendo de la eleccion del usuario se llama el algoritmo necesario%
          switch (choice)
          case 1 % biseccion
             % Se recorren la matriz de parametros%
             for i = 1:1:length(m_parameters) % itera la cantidad de ecuaciones que tenga la matriz de parametros
               disp('------------------------------------');
               disp('Se llama el algoritmo de bisección con los siguientes parametros: ');
                 fn = m_parameters(i,1) % ecuacion %
                 a = double(m_parameters(i,3)) % intervalo 1 %
                 b = double(m_parameters(i,4)) % intervalo 2 %
                 error = double(m_parameters(i,7)) % tolerancia de error %
                 tic;
                 tStart = cputime;
                 solutions = biseccion(fn,a, b, error ); % Se llama el algoritmo de biseccion %
                 solutions
                 cpu_biseccion(i)= cputime - tStart;
                 elapsed_time = toc();
                 biseccion_time(i) = elapsed_time;
               disp('------------------------------------');
             endfor
              % se grafican los tiempos %
              plot (1:length([biseccion_time; cpu_biseccion]),[biseccion_time; cpu_biseccion]);
              xlabel ("# Ecuación");
              ylabel ("Tiempo Transcurrido (segundos)");
              title (" Comparar procesamiento del algoritmo y el tiempo en CPU (Bisección)");
              legend('Algoritmo','CPU')
          case 2 % NewtonRaphson
            % Se recorren la matriz de parametros%
             for i = 1:1:length(m_parameters) % itera la cantidad de ecuaciones que tenga la matriz de parametros
               disp('------------------------------------');
               disp('Se llama el algoritmo de NewtonRaphson con los siguientes parametros: ');
                 fn = m_parameters(i,1) % ecuacion %
                 x0 = double(m_parameters(i,5)) % x0 %
                 iteraciones = double(m_parameters(i,6)) % iteraciones %
                 error = double(m_parameters(i,7)) % tolerancia de error %
                 tic;
                 tStart = cputime;
                 solutions = newton_rph(fn,x0,error,iteraciones ); % Se llama el algoritmo de newton_rph %
                 solutions
                 cpu_newton(i)= cputime - tStart;
                 elapsed_time = toc();
                 newton_time(i) = elapsed_time;
               disp('------------------------------------');
             endfor
              % se grafican los tiempos %
              plot (1:length([newton_time; cpu_newton]),[newton_time; cpu_newton]);
              xlabel ("# Ecuación");
              ylabel ("Tiempo Transcurrido (segundos)");
              title (" Comparar procesamiento del algoritmo y el tiempo en CPU (NewtonRaphson)");
              legend('Algoritmo','CPU');
          case 3 % Punto fijo
            % Se recorren la matriz de parametros%
             for i = 1:1:length(m_parameters) % itera la cantidad de ecuaciones que tenga la matriz de parametros
               disp('------------------------------------');
               disp('Se llama el algoritmo de Punto fijo con los siguientes parametros: ');
                 fn = m_parameters(i,1) % ecuacion original%
                 gx = m_parameters(i,2) % ecuacion en terminos de g(x) = x %
                 x0 = double(m_parameters(i,5)) % x0 %
                 iteraciones = double(m_parameters(i,6)) % iteraciones %
                 error = double(m_parameters(i,7)) % tolerancia de error %
                 tic;
                 tStart = cputime;
                 solutions = punto_fijo(gx,x0, iteraciones, error ); % Se llama el algoritmo de Punto fijo %
                 solutions
                 cpu_fijo(i)= cputime - tStart;
                 elapsed_time = toc();
                 time_fijo(i) = elapsed_time;
               disp('------------------------------------');
             endfor
              % se grafican los tiempos %
              plot (1:length([time_fijo; cpu_fijo]),[time_fijo; cpu_fijo]);
              xlabel ("# Ecuación");
              ylabel ("Tiempo Transcurrido (segundos)");
              title (" Comparar procesamiento del algoritmo y el tiempo en CPU (Punto fijo)");
              legend('Algoritmo','CPU');
          otherwise
            %Se termina el programa%
            msgbox('Hasta pronto mi pequeño Padawan !! ');
            index = 0;
          endswitch
        endwhile

        total_time = [cpu_biseccion; cpu_newton; cpu_fijo];
        if length(total_time) == 10
          plot (1:length(total_time),total_time);
          xlabel ("# Ecuación");
          ylabel ("Tiempo de ejecución (segundos)");
          title (" Comparar procesamiento de los algoritmos");
          legend('CPU - Biseccion','CPU - NewtonRaphson','CPU - Punto fijo')
        endif
        % Se habilitan las alertas %
        warning('on', 'all');
      endfunction

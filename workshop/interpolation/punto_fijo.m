function sol = punto_fijo(g,x0, interaciones, toleracia )
  syms x;
  tic;
  g_derivada = diff(g, x , 1); # primera derivada

  # transformar las funciones simbolicas
  g_derivada_handle = function_handle(g_derivada,'vars',[x]);
  g_handle = function_handle(g,'vars',[x]);

  # evaluar en la derivada --> Teorema existencia y unicidad

  if abs(g_derivada_handle(x0)) < 1
    # msgbox('Funcion adecuada');
    # realizar interaciones y evaluar error
    # X_i+1 = g(X_i)

    sol(1) = x0;

    for i = 1 : 1 : interaciones
      sol( i + 1) = g_handle(sol(i));
      error = abs(sol(i + 1) - sol(i) / sol(i + 1) );
      if error < toleracia
        i
        break;
      endif
    endfor
  else
    disp('Funcion no es la adecuada');
    sol(1) = 0;
  endif

  toc;

  endfunction

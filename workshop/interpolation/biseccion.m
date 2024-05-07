function sol = biseccion(fun, a, b, error)

  # compara si tiene solucion en el intervalo
  if sign(subs(fun, a)) == sign(subs(fun, b))
    disp('Ese intervalo no sirve, busque otro intervalo');
    sol = 0;
  else
    tic
    # Calcular el numero de iteraciones
    iteraciones = log2(abs((a - b)/error));
    iteraciones = ceil(iteraciones)

    # Metodo de biseccion
    i = 1;
    for i = 1:iteraciones

      resultado = (a + b) / 2;

      evaluar = subs(fun, resultado);

      if sign(evaluar) == sign(subs(fun, a))
        a = resultado;
      else
        b = resultado;
      endif
      i = i + 1;
    endfor
    sol = resultado;
    elapsed_time = toc();
  endif

endfunction



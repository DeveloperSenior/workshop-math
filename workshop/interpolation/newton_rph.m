function sol = newton_rph(fn, x0, toleracia, iteraciones)

  syms x;
  # derivar la funcion
  fn_diff =  diff(fn,x,1);
  fn_h = function_handle(fn);
  fn_diff_h = function_handle(fn_diff);

  # iniciamos newton rapshon
  sol(1) = x0;

  for i = 2: 1: iteraciones

    sol(i) = sol( i - 1) - fn_h( sol(i - 1)) / fn_diff_h( sol(i - 1) );
    error = abs( (sol(i) - sol(i - 1)) / sol(i) );
    if error < toleracia
      #i
      sol(i)
      #error
      #fn_h(sol(i))
      #plot(sol);
      break;
    endif

  endfor

 endfunction

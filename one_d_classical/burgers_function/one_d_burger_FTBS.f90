  !This is for multiple solution of one dimension of CFD



Program one_d_burger_FTBS
  use boundary_conditions
  use scheme

  !============parameter settings============


  implicit none
  integer::isetval
  integer,parameter ::ispace=100,itime=20
  real(kind=8),parameter::c=1,sigma=0.4, vis=0.07
  real(kind=8)::dt,dx,t,x
  real(kind=8),dimension(ispace+1)::u0,x_value,u
  real(kind=8),dimension(itime+1)::t_value
  character(40)::ch, fmt, filename
  logical::debug=.False.
  ! debug=.True.
  !========================

  !============set some global parameters============
  call initialize()
  x=4
  dx=x/(ispace)
  dt=dx*vis
  t=dt*itime
  print 1010,dt

1010 format(' t = ', es24.14)

  !============boundary_conditions============

  !     !============heaviside ============
  call burgers_ini_cond(itime,ispace,t,x,t_value,x_value,u0,vis,debug)
  !============one_d_linear_advection: ============

  !============one_d_diffusion:FTCS============ subroutine one_d_diffusion (vis,dt,t,dx,x,u0,u)

  call one_d_bg_FTBS (vis,dt,t,dx,x,u0,u);filename='one_d_burger_FTBS'

  !  ============test============


  if (debug) then
     Do isetval=1,ispace+1
        print 201, x_value(isetval), u(isetval)
     enddo
201  format(2es24.10)
  endif


  !============write to file============


  open(unit=1001,file=trim(filename)//'_results.txt',status='replace')
  Do isetval=1,ispace+1

     write(1001, 301) x_value(isetval),u(isetval)
  enddo
301 format(2es24.14)
  close(unit=1001)


end program one_d_burger_FTBS

!!!!
!! File: dotprod_pseudo_omp2.f90
!! Description: Hints to parallelize Dot Product with OpenMP
!! Author: Bruno R. de Abreu  |  babreu at illinois dot edu
!! National Center for Supercomputing Applications (NCSA)
!!  
!! Creation Date: Wednesday, 26th January 2022, 9:24:09 am
!! Last Modified: Wednesday, 26th January 2022, 9:26:09 am
!!  
!! Copyright (c) 2022, Bruno R. de Abreu, National Center for Supercomputing Applications.
!! All rights reserved.
!! License: This program and the accompanying materials are made available to any individual
!!          under the citation condition that follows: On the event that the software is
!!          used to generate data that is used implicitly or explicitly for research
!!          purposes, proper acknowledgment must be provided in the citations section of
!!          publications. This includes both the author's name and the National Center
!!          for Supercomputing Applications. If you are uncertain about how to do
!!          so, please check this page: https://github.com/babreu-ncsa/cite-me.
!!          This software cannot be used for commercial purposes in any way whatsoever.
!!          Omitting this license when redistributing the code is strongly disencouraged.
!!          The software is provided without warranty of any kind. In no event shall the
!!          author or copyright holders be liable for any kind of claim in connection to
!!          the software and its usage.
!!!!

program dotprod_hints
    use, intrinsic :: iso_fortran_env
    ! ## HINT1 include OpenMP module here ##
    implicit none
    integer, parameter :: dp = REAL64   ! double precision
    integer, parameter :: ORD = 2**29   ! arrays size
    real(dp), dimension(:), allocatable :: v1, v2   ! arrays
    real(dp) :: dotp    ! this will hold the dot product
    integer :: i        ! this will run loops over the arrays
    ! ## HINT1 add variables to track time ##

    ! allocate arrays
    allocate(v1(ORD))
    allocate(v2(ORD))

    ! attribute values to arrays (random numbers)
    call random_seed()  ! start RNG
    call random_number(v1)
    call random_number(v2)

    ! calculate dot product
    dotp = 0.0_dp
    ! ## HINT1 trigger stopwatch ##
    ! ## HINT1 open omp parallel region -- what variables are shared? ##
    ! ## HINT1 insert omp loop -- what is private to each thread? ##
    ! ## HINT2 use a reduction clause (sum) in this loop directive ##
    do i = 1, ORD
        dotp = dotp + v1(i)*v2(i)
    enddo
    ! ## HINT1 close omp directives and trigger stopwatch ##

    ! ## HINT1 print execution time here ##

    ! print result
    write(*,*) 'Dot product is: ', dotp

    ! ## HINT1 check your result here ##
    ! ## HINT2 the random numbers are uniformly distributed over the (0,1) interval.
    ! ##        What is the expected value of dotp? ##          

    ! cleanup and goodbye
    deallocate(v1,v2)

end program dotprod_hints

# Project 1
COP5615 - Distributed Operating Systems Principles Project 1

The input provided (as command line to your program, e.g. my app) will be two numbers: N and k. The overall goal of your program is to find all k consecutive numbers starting at 1 and up to N, such that the sum of squares is itself a perfect square (square of an integer).

## Group Information
* **Ayush Mittal** - *UF ID: 3777 8171*
* **Shivaditya Jatar** - *UF ID: 6203 9241*

## Contents of this file

Introduction, Prerequisites, Instruction Section, Project Questions

## Introduction
Our project has two different modules :-

1. Server: This module uses GenServer. Our server module calls the main GenServer in Elixir which is helpful in passing messages and helps in maintaining the state as well. In our case the initial state is the (n) and (k) which are entered the first time. The GenServer is initialized with this value. The Server acts as a boss and assigns each new actor, the starting element of the sequence to be calculated.

2. Worker: This module contains spawnActors() function which is responsible for spawning new actors and for parallel calculation of the starting points of the sequence. This is carried out using recursion.


## Prerequisites

#### Erlang OTP 21(10.0.1)
#### Elixir version 1.7.3

## Instruction section

##### To run the App

```elixir
(Before running, Goto proj1 directory, where mix.exs and proj1.exs files are present)
$ cd proj1
$ mix run proj1.exs <n> <k>
eg. mix run proj1.exs 40 24
O/P->    1
    	 9
    	 20
    	 25
```
Starts the app, passing in n and k values. The console begins printing the output on independent lines. The input consist of 2 values, n and k, separated by space and the output values are the starting points of the possible sequences.

## Project questions

* **Size of the work unit**

In the program, the actor receives the starting point of the sequence to be calculated. We spawn (n) worker processes for doing the computations and for enabling maximum possible parallelism. We also tried running our project by assigning different work unit sizes (5,10...) to each actor, but we got the best performance when we assigned each actor a single starting point.  

* **Sample Output**

The following output was generated for command ```$ mix run project1.exs 1000000 4 ```
Since, no desired sequence was found therefore, No output was generated for the above values of (n) and (k).

* **Running Time**

For checking running times, use command :
```elixir
$ time mix run project1.exs 1000000 4

  real->  0m5.660s
  user->  0m18.828s
  sys->   0m0.405s
```
CPU time = User time + Sys time = 18.828 + 0.405 = 19.233

The ratio of CPU time to REAL time :-
(CPU time)/(Real time) = 19.233/5.660 =  **3.398**

Since the ratio is well above 1, our program is utilizing multiple cores for computation.

* **Largest problem**

We managed to run the code for n=120000000 , k=4 as the largest possible problem.
After this as we increased the value of (n) by some constant factors, it showed "[error] Too many processes".
The largest problem possible will depend on both (n) and (k) i.e some f(n,k).

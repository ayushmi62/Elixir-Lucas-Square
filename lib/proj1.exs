#This is the GenServer module which has the init, start_link & jobAssign functions"
defmodule Proj1 do

use GenServer

  #The GenServer is started using this function
  def start_link() do
    # :observer.start                             #used to start the erlang observer to check the processes & core utilization
    arg = System.argv()                           #get arguments from the command line
    {:ok,pid} = GenServer.start_link(Proj1,arg)   #passes the arguments according to process id to the init funtion
    {pid}
  end

  #The GenServer is initialized with initial data from start_link, which are N(upper limit) and k(sequence length)
  def init(initial_data) do
    values = initial_data
    cond do
      Kernel.length(initial_data) == 2 ->
        m = String.to_integer(Enum.at(initial_data, 0))
        n = String.to_integer(Enum.at(initial_data, 1))
        Worker.spawnActors(0,m,n)                 #pass the arguments i.e., sequence length & N to the
      true ->
        IO.puts "Enter required number of arguments"
    end
    {:ok,values}                                  #spawnActors function of worker module to create new actors
  end

  #called every time to give the new starting point to calculate the squares from
  def jobAssign(count) do
    count = count+1;
    count
  end

end

#This is the Worker module which consists of the functions of the worker
defmodule Worker do

  #The worker spawns threads until limit is reached and calculate squares
  def spawnActors(count, limit, size) do
    if count === limit+1 do
      :break
    else
      new = Proj1.jobAssign(count)                #get new starting point of squares from jobAssign function
      spawn(__MODULE__, :calc_square, [new,size]) #spawns new process and calls new function to calculate squares
      spawnActors(new, limit,size)                #called in recursion with new staring point, for checking arguments & spawning new actors
    end
  end

  #This function is spawned everytime; it finds if the sum of squares is perfect square or not
  def calc_square(count,size) do
    sqroot = :math.sqrt(Enum.sum(Enum.map(Enum.to_list(count..count+size-1), fn x -> x * x end)))
    sqr = Float.ceil(sqroot,0)
    if (sqr - sqroot)>0 do
    else
      IO.puts "#{count}"                          #prints the starting point of consecutive squares if satisfies conditions
    end
  end

  Code.compiler_options(ignore_module_conflict: false)
end

Proj1.start_link()                                #calls start_link initially

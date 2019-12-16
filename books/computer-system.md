# Part 0
# A Tour of Computer System

> This book consists of hardware and systems software that work together to run application progarams. Specific implementations of systems change over time, but the underlying concepts do not. It is written for programmers who want to get better at their craft by understanding how these components work and how they affect the correctness and performance of their programs.

Interesting topics covered:

- how to avoid strange numerical errors caused by the way that computers represent numbers.
- how to toptimize your C code by using clever tricks that exploit the designs of modern processors and memory systems.
- how the compiler implements prodecudure calls and how to use this knowledge to avoid the security holes from buffer overflow vulnerabilities
- how to recognize and avoid the ansty errors during linking 
- how to write your own Unix shell, your own dynamic storage allocation package, your own Web server
- the promises and pitvfalls of concurrency

## C language

- Created by K&R, Kernighan and Richie

### How does the hello.c source file produce text on screen?

- At first we have just the text file hello.c, represented by ASCII characters.
	- 2 type of files: text & binary 

- Preprocess
	- insert header file content into source file
	- remove comments
	- produce hello.i file

- Compile
	- compiled by compiler driver
	- produce hello.s file, assembly code

- Assemble
	- Assembled by the assembler
	- produce hello.o file, relocatable object file

- Link
	- Linked by the linker
	- linked with printf.o file, a precompiled relocatable object program
	- produce hello binary file, executable object file 

### Benefits of understanding how compilation system work 

- optimizing program performance
	- in order to make good coding decisions in our C programs, we do need a basic understanding of machine level code and how compiler translates different C statements into machine code
	- E.g is a switch statement always more efficient than a sequence of if-else statements
	- how much overhead is incurred by a functin call?
	- Is a while loop more efficient than a for loop?
	- are pointer references more efficient than using array?
	- why does our loop run so much faster if we sum into a local variable instead of an argument that is passed by reference?
	- how can a function run faster when we simple rearrange the parenteses in an arithmetic expression?

- understanding link-time errors
	- what does it mean when the linker reports that it cannot resolve a reference?
	- what is the difference between a static variable and a global variable?
	- what happens if you define two global variables in different C files with the same name?
	- what is the difference betwwen a static library and a dynamic libary?
	- why does it matter what order we list libraries on the command line?
	- why do some linker-related errors not appear until runtime?

- avoid security holes
	- buffer overflow vulerabilities is a major issue
	- understand the consequences of the way data and control informatino are stored on the program stack

### Hardware organtization of a system

- Buses
	- carry bytes of information back and fort between components
	- fixed size of bytes called word
	- word size is variable across systems: 4(32 bits) bytes or 8(64 bits) bytes

- I/O devices
	- each devices is connected to I/O buses by device controller or adapter
	- Controllers are chipsets in the device itselft or on the system's motherboard
	- An adapter is a card that plugs into a slot on the motherboard

- Main memory
	- temporary storage that holds both a program and the data it manipulates while the processor is executing the program.
	- a collection of dynamic random access memory: DRAM

- The central processing unit (CPU)
	- execute the instructions stored in memory
	- At its core is a word-sized storage device (or register) called the program counter. At any point in time, the PC points at some machine-language instruction in main memory
	- the processor repeatedly executes the instruction pointed at by the PC and updates the PC to point to the next instruction.
	- The processor operate according to the instruction execution model, defined by its instruction set artchitecture.
		- Executing an instruction involves performing a series of steps
		- read the instruction from memory.
		- interprets the bits in the instruction, perform the operation dictated by the instruction.
		- update the PC to point the the next instruction
	- All the operations revolve around main memory, registers, and arithmetic logic unit(ALU)
	- Some example of the operations:
		- Load: copy a byte or a word from main meory into a register, overwriting the previous contents of the register
		- Store: Copy a byte or a word from a register to a loation in main memory, overwriting the previous contents of that location
		- Operate: Copy the contents of two registers to the ALU, perform an arithmetic operation on the two words, and store the result in a register, overwriting the previous contents of that register
		- Jump: Extract a word from the instruction itseflt and copy that word into the PC, overwriting the previous value of the PC
	- It appears to be a simple implementation of its instruct set archirtecture, but in fact modern processors use far more complex mechanisms to speed up program execution.

### How does the hello program executed?

- Initially, the shell pgoram is executing its instructions, waiting for us to type a command
- When we type ./hello into the keyboard, the keyboard controller sends bytes of "./hello" to I/O bus
- The CPU got the data and send ./hello to the display device through the display adapter (or controller)
- When we hit enter, the CPU understand that we've finished writing a command.
- the shell loads the executable hello file into main memory by executing a sequence of instruction that copies the code and data inthe hello object file from disk to main memory
- using the technique known as direct memory access, the data travels directy from disk to main meory without passing through the processor
- the processor begins executing the machine-la nguage instructions in the hello prgram's main routine.
- these instructions copy the bytes in the "hello, world\n" string from memory to the register file, and from there to the display device

## Caches matter

- Notice that there's a lot of copying operation. From disk to memory, memory to register...
- A major goal for system desginers is to make these copy operations run as fast as possible
- Processor-memory gap is increasing over the years.
- System designers include smaller faster storage devices called cache memories that serve as temporary staging areas for information that processor is likely to need in near future.
- L1 cache can hold ten of thousands of bytes and can be nearly as fast as the register
- L2 cache can hold hundred of thousands to millions of bytes is connected to the processor by a special bus. Might take 5 times slower than L1.
- L1 & L2 are implemented by a hardware technology known as static random access memory (SRAM)

## Storage devices

- storage at one level serves as a chache for storage at the next lower level.
- L0(regs), L1(SRAM), L2(SRAM), L3(SRAM), L4(DRAM), l5(Disk), L6(distributed file systems, web servers)

## Operating system manages the hardware

- We can think of the OS as a layer of sotware interposed between the application program and the hardware
- All attempts by an application program to manipulate the hardware must go through the OS.
- Two main purposes of OS:
	- protect the hardware from misuse buy applications
	- provide applications with simple and uniform mechanism for manipulating complicated and often wildly different low-level hardware devices.
- The OS achieve these two goals by the fundamental abstractions:
	- Files for I/O devices
	- Virtual memory for main memory & IO devices
	- Processes for processor, main meory and I/O devices


### Processes

- The OS provides the illusion that your program is the only one running, and has exclusive access to processors, memory and IO devices
- This illusions is made possible by the concept of Process
- A process is the operating system's abstraction for running a program. With a machanisms known as context switching, the OS switch the programs a single processor, allowing them to run concurrently
- The OS keep track of the state of the process, include the PC, register file, contents of memory. At any point in time, a processor can only execute instruction from a single process.
- When context switching, the OS save the state(context) of the current process, restore the state of the new process, and then passing control to the new process


### Threads

- A processs can consist of multiple execution units called threads.
- each running in the context of the process, and sharing the same code and global data.
- It's easier to share data between threads than between multiple processes
- Multi threading is also one way to make programs run faster twhen wmultiple processors are available


### Virtual memory

- An abstraction to provide each process with the ullusion that it has exclusive use of the main memory.
- Each process has the same uniform view of the virtual address space
- In Linux, the top most region is reserved for code and data in the OS that is common to all process
- The lower region of the address space holds the code and data defined by the user's process
- From bottom up: Program code and data:
	- Code beginds at the same fixed address for all process
	- Followed by data locations that is correspond to global C variables. The code and data areas are initialized directly from the contents of an executable ojbject file.
	- Heap. The code and global data is followed by the runtime heap. Unlike the code and data areas, which are fixed in size once the process begins running, the heap expands and contracts dynamically at run time as a result of calls to C std lib routines such as malloc and free.
	- Shared libraries. Near the middle of the address space is an area that holds the code and data for shared libraries such as the C std lib and the math library.
	- Stack. At the top of the user's virtual address space is the user stack that the compiler uses to implement function calls. Like the heap, the user stack expands and contracts dynamically during the execution of the program.
	- Kernel virtual memory. The kernel is part of the OS that is always resident at the top region of the address space. Application programs are not allow to read/write data or call to the code inside this region.
- There has to be a machanism to translate between hardward address generated by the processor to the address in the virtual address space. The basic idea uis to store the contents of a process's virtual memory on disk, and then use the main meory as a cache for the disk.

### Files

- Is a sequence of bytes. Nothing more, nothing less. Every IO device is modeled as a file.
- All input and output in the system is performed by reading and writing files, using a small set of system calls known as Unix IO
- This is simple and elegant but very powerful because it provides applications with a uniform view of all the varied IO devices that might be contained in the system.


## Systems commnunicate with other systems using networks

Read and write to network devices

### Important themes

Some important concepts that cut across all aspects of computer systems.

#### Concurrency and Paralleism

- Concurrency: the concept of a system with multiple, simultaneous activities
- Parallelism: the use of concurrency to make system run faster

Parallelism can be exploited at multiple levels of abstractions. From highest to lowest:

#### Thread-level concurrency:
	- Like process abstraction, we can have multiple control flow executing within a single process
	- Multi-cores processors: have multiple cores, each has its own L1 and L2 cache but share memory interface and higher cache levels
	- Hyper threading: Allow a single CPU to execute multiple control flows. By having multiple copies of some of the CPU hardware, such as PC and registers, while having single copies of other parts of the hardware. While it takes 20k cycles for thread switching, hyperthreading processor decides which thread to execute on on a cycle-by-cycle basis.
	- Benefit of multiprocessing:
		- reduce the need to simulate concurrency
		- can run a single application program faster

#### Instruction level prallelism:
	- At a much lower level of abstraction, modern processors can execute multiple instructino at one time. Using pipelining.
	- Processors that can sustain execution rates faster than one instruciton per cycle are known as superscalar processors. 

#### Single-instruction, multiple data (SIMD), parallelism
	- many modern processors have special hardware that allows a single instruction to cause multiople operations to be perfored in parallel.
	- For example, recent gernations of Intel and AMD processors have instructions that can add four paris of single-precision floating point numbers in parallel


## The importance of Abstraction

The instruction set architecture provides an anstraction of the actual processor hardware. With this abstraction, a machine-code program behaves as if it were executed on a processor that performs just one instruction at a time. The underlying hardware is far more capable, executing multiple instructions in parallel. But always consistent to a simple sequental execution model. By keeping this simple execution model, different processor implementations can execute the same machine code.

# Part 1
# Program structure and execution

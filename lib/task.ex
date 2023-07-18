defmodule Wahsm.Task do
    use Task

    def start_link(arg) do
        Task.start_link(__MODULE__, :run, [arg])
    end

    def run(_) do
        tasks = Enum.map(0..99, fn(x) ->
            Task.Supervisor.async_nolink(Wahsm.TaskSupervisor, fn -> Wahsm.init_memory(x) end)
        end)

        results = Task.yield_many(tasks)
        Enum.map(results, fn {_, x} -> handle_res(x) end)
    end

    def handle_res(x) do
        case x do
            { :ok, { :ok, n, pid, ptr } } -> check(n, pid, ptr)
            _ -> IO.puts("error")
        end
    end

    def check(n, pid, ptr) do
        { :ok, store } = Wasmex.store(pid)
        { :ok, memory } = Wasmex.memory(pid)
        num = Wasmex.Memory.get_byte(store, memory, ptr)

        case num do
            ^n -> IO.puts("ok #{n} #{ptr}")
            _ -> IO.puts("error #{n}")
        end

    end
end

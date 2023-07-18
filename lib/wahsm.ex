defmodule Wahsm do
    def init_memory(num) do
        bytes = File.read!("main.wasm")
        { :ok, instance_pid } = Wasmex.start_link(%{ bytes: bytes })
        { :ok, [ ptr ] } = Wasmex.call_function(instance_pid, "init_memory", [ num ])
        { :ok, store } = Wasmex.store(instance_pid)
        { :ok, memory } = Wasmex.memory(instance_pid)
        n = Wasmex.Memory.get_byte(store, memory, ptr)

        case n do
            ^num -> { :ok, n, instance_pid, ptr }
            _ -> n
        end
    end
end

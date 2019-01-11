defmodule Chain do
  defstruct(
    next_node: nil,
    count: 100000
  )

  def start_link(next_node) do
    spawn_link(Chain, :message_loop, [ %Chain{ next_node: next_node } ])
    |> Process.register(:chainer)
  end

  def message_loop(%{count: 0}) do
    IO.puts "done"
  end

  def message_loop(state) do
    receive do
      {:trigger, _list} ->
        send { :chainer, state.next_node }, { :trigger, [ ] }
    end
    message_loop(%{ state | count: state.count - 1 })
  end
end

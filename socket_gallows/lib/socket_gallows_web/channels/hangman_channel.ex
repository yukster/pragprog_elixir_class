defmodule SocketGallowsWeb.HangmanChannel do
  use Phoenix.Channel
  require Logger

  # new Jason.Encoder (replaced Posion?) requires this
  @derive Jason.Encoder
  defstruct data: nil

  def join("hangman:game", _, socket) do
    game = Hangman.new_game()
    socket = assign(socket, :game, game)
    { :ok, socket }
  end

  def handle_in("tally", _, socket) do
    tally = encodable_tally(Hangman.tally(socket.assigns.game))
    push(socket, "tally", %SocketGallowsWeb.HangmanChannel{data: tally})
    { :noreply, socket }
  end

  def handle_in("make_move", guess, socket) do
    game = socket.assigns.game
    tally = Hangman.make_move(game, guess)
            |> encodable_tally()
    push(socket, "tally", %SocketGallowsWeb.HangmanChannel{data: tally})
    { :noreply, socket }
  end

  def handle_in("new_game", _, socket) do
    socket = socket |> assign(:game, Hangman.new_game())
    handle_in("tally", nil, socket)
  end

  def handle_in(type, _, socket) do
    Logger.error("Recieved unknown channel request: #{type}")
    { :reply, :error, socket }
  end

  # hack to work around Jason.Encode not doing MapSet by default
  # (should have just left in my hangman temporary change to keeping "used" in a list)
  defp encodable_tally(tally) do
    %{ tally | used: MapSet.to_list(tally.used) }
  end
end

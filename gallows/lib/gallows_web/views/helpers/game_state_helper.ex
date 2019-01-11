defmodule GallowsWeb.HangmanView.GameStateHelper do
  import Phoenix.HTML, only: [ raw: 1 ]

    @responses %{
    won: { :info, "You won!" },
    lost: { :danger, "You lost!" },
    good_guess: { :info, "Good guess!" },
    bad_guess: { :warning, "Bad guess!" },
    already_used: { :warning, "You already guessed that" }
  }

  def show_tally(tally) do
    tally.letters |> Enum.join(" ")
  end

  def letters_guessed(tally) do
    tally.used
    |> MapSet.to_list()
    |> Enum.join(" ")
  end

  def game_state(state) do
    @responses[state]
    |> alert()
  end

  defp alert(nil), do: ""

  defp alert({class, message}) do
    """
    <div class="alert alert-#{class}">
      #{message}
    </div>
    """
    |> raw()
  end

end

defmodule ClientLiveViewWeb.Impl.Live.Hangman.Tally do
  use ClientLiveViewWeb.Impl, :live_component

  @state %{
    initial: "Type or click on your fist guess",
    won: "You've won!",
    good_guess: "Good guess!",
    bad_guess: "Nope...",
    lost: "Game Over...",
    repeated_guess: "Letter already played..."
  }

  def mount(socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="hangman_overview">
      <h3 class="hangman_word"><%= @tally.hangman |> Enum.join(" ") %></h3>
      <p class="hangman_tally">
          Turns left: <%= @tally.turns_left %> <br>
          Letters used: <%= @tally.used_letters |> Enum.join(", ") %> <br>
          <%= render_state(@tally.state) %>
      </p>
    </div>
    """
  end

  defp render_state(state) do
    @state[state]
  end
end

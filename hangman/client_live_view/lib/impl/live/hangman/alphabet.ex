defmodule ClientLiveViewWeb.Impl.Live.Hangman.Alphabet do
  use ClientLiveViewWeb.Impl, :live_component

  def mount(socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="hangman_alphabet">
      <%= for letter <- assigns.alphabet do %>
        <span
          phx-click="make_move"
          phx-value-key={letter}
          class={"hangman_letter #{resolveClass(assigns.tally, letter)}"}
        >
          <%= letter %>
        </span>
      <% end %>
    </div>
    """
  end

  defp resolveClass(tally, letter) do
    cond do
      Enum.member?(tally.hangman, letter) -> "correct"
      Enum.member?(tally.used_letters, letter) -> "wrong"
      true -> ""
    end
  end
end

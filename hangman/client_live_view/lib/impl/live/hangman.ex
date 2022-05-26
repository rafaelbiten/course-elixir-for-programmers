defmodule ClientLiveViewWeb.Impl.Live.Hangman do
  use ClientLiveViewWeb.Impl, :live_view

  @alphabet Enum.map(?a..?z, &<<&1::utf8>>)

  def mount(_params, _session, socket) do
    game = Hangman.new_game()
    tally = Hangman.get_tally(game)

    socket = assign(socket, %{game: game, tally: tally})

    {:ok, socket}
  end

  def render(assigns) do
    alphabet = @alphabet

    ~H"""
    <h1>Hangman Game</h1>
    <%= live_component(__MODULE__.Alphabet, alphabet: alphabet, tally: assigns.tally, id: "words_so_far") %>
    <div class="hangman_grid" phx-window-keyup="make_move">
    <%= live_component(__MODULE__.Figure, tally: assigns.tally, id: "figure") %>
    <%= live_component(__MODULE__.Tally, tally: assigns.tally, id: "tally") %>
    </div>
    """
  end

  def handle_event("make_move", %{"key" => key}, socket) when key in @alphabet do
    tally = Hangman.make_move(socket.assigns.game, key)
    {:noreply, assign(socket, %{tally: tally})}
  end

  def handle_event("make_move", _assigns, socket), do: {:noreply, socket}
end

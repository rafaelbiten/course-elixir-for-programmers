defmodule ClientLiveViewWeb.Impl.Live.Hangman.Figure do
  use ClientLiveViewWeb.Impl, :live_component

  def mount(socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <pre class="hangman">
      <%= ClientLiveViewWeb.Impl.HangmanHelpers.render_hangman(@tally.turns_left) %>
    </pre>
    """
  end
end

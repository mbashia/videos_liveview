defmodule VideosLiveviewWeb.VideoLive.FormComponent do
  use VideosLiveviewWeb, :live_component

  alias VideosLiveview.Videos

  @impl true
  def update(%{video: video} = assigns, socket) do
    changeset = Videos.change_video(video)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)
     |> assign(:uploaded_files, [])
     |> allow_upload(:video, accept: ~w(.mp4), max_entries: 1)}
  end

  @impl true
  def handle_event("validate", %{"video" => video_params}, socket) do
    changeset =
      socket.assigns.video
      |> Videos.change_video(video_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"video" => video_params}, socket) do
    uploaded_files =
      consume_uploaded_entries(socket, :video, fn %{path: path}, _entry ->
        dest =
          Path.join([:code.priv_dir(:videos_liveview), "static", "videos", Path.basename(path)])

        # The `static/videos` directory must exist for `File.cp!/2`
        # and MyAppWeb.static_paths/0 should contain videos to work,.
        File.cp!(path, dest)
        {:ok, "/videos/" <> Path.basename(dest)}
      end)

    {:noreply, update(socket, :uploaded_files, &(&1 ++ uploaded_files))}

    new_video_params = Map.put(video_params, "video_url", List.first(uploaded_files))

    save_video(socket, socket.assigns.action, new_video_params)
  end

  defp save_video(socket, :edit, video_params) do
    case Videos.update_video(socket.assigns.video, video_params) do
      {:ok, _video} ->
        {:noreply,
         socket
         |> put_flash(:info, "Video updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_video(socket, :new, video_params) do
    case Videos.create_video(video_params) do
      {:ok, _video} ->
        {:noreply,
         socket
         |> put_flash(:info, "Video created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end

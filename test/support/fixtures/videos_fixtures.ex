defmodule VideosLiveview.VideosFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `VideosLiveview.Videos` context.
  """

  @doc """
  Generate a video.
  """
  def video_fixture(attrs \\ %{}) do
    {:ok, video} =
      attrs
      |> Enum.into(%{
        description: "some description",
        title: "some title",
        video_url: "some video_url"
      })
      |> VideosLiveview.Videos.create_video()

    video
  end
end

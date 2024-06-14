defmodule VideosLiveview.Videos.Video do
  use Ecto.Schema
  import Ecto.Changeset

  schema "videos" do
    field :description, :string
    field :title, :string
    field :video_url, :string

    timestamps()
  end

  @doc false
  def changeset(video, attrs) do
    video
    |> cast(attrs, [:title, :description, :video_url])
    |> validate_required([:title, :description, :video_url])
  end
end

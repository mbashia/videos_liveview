defmodule VideosLiveview.Repo.Migrations.CreateVideos do
  use Ecto.Migration

  def change do
    create table(:videos) do
      add :title, :string
      add :description, :string
      add :video_url, :string

      timestamps()
    end
  end
end

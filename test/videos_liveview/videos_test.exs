defmodule VideosLiveview.VideosTest do
  use VideosLiveview.DataCase

  alias VideosLiveview.Videos

  describe "videos" do
    alias VideosLiveview.Videos.Video

    import VideosLiveview.VideosFixtures

    @invalid_attrs %{description: nil, title: nil, video_url: nil}

    test "list_videos/0 returns all videos" do
      video = video_fixture()
      assert Videos.list_videos() == [video]
    end

    test "get_video!/1 returns the video with given id" do
      video = video_fixture()
      assert Videos.get_video!(video.id) == video
    end

    test "create_video/1 with valid data creates a video" do
      valid_attrs = %{
        description: "some description",
        title: "some title",
        video_url: "some video_url"
      }

      assert {:ok, %Video{} = video} = Videos.create_video(valid_attrs)
      assert video.description == "some description"
      assert video.title == "some title"
      assert video.video_url == "some video_url"
    end

    test "create_video/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Videos.create_video(@invalid_attrs)
    end

    test "update_video/2 with valid data updates the video" do
      video = video_fixture()

      update_attrs = %{
        description: "some updated description",
        title: "some updated title",
        video_url: "some updated video_url"
      }

      assert {:ok, %Video{} = video} = Videos.update_video(video, update_attrs)
      assert video.description == "some updated description"
      assert video.title == "some updated title"
      assert video.video_url == "some updated video_url"
    end

    test "update_video/2 with invalid data returns error changeset" do
      video = video_fixture()
      assert {:error, %Ecto.Changeset{}} = Videos.update_video(video, @invalid_attrs)
      assert video == Videos.get_video!(video.id)
    end

    test "delete_video/1 deletes the video" do
      video = video_fixture()
      assert {:ok, %Video{}} = Videos.delete_video(video)
      assert_raise Ecto.NoResultsError, fn -> Videos.get_video!(video.id) end
    end

    test "change_video/1 returns a video changeset" do
      video = video_fixture()
      assert %Ecto.Changeset{} = Videos.change_video(video)
    end
  end
end

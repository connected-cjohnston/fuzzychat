defmodule Fuzzychat.MessagesTest do
  use Fuzzychat.DataCase

  alias Fuzzychat.Messages

  describe "messages" do
    alias Fuzzychat.Messages.Message

    import Fuzzychat.MessagesFixtures

    @invalid_attrs %{message: nil, room_id: nil, user_id: nil}

    test "list_messages/0 returns all messages" do
      message = message_fixture()
      assert Messages.list_messages() == [message]
    end

    test "get_message!/1 returns the message with given id" do
      message = message_fixture()
      assert Messages.get_message!(message.id) == message
    end

    test "create_message/1 with valid data creates a message" do
      valid_attrs = %{message: "some message", room_id: 42, user_id: 42}

      assert {:ok, %Message{} = message} = Messages.create_message(valid_attrs)
      assert message.message == "some message"
      assert message.room_id == 42
      assert message.user_id == 42
    end

    test "create_message/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Messages.create_message(@invalid_attrs)
    end

    test "update_message/2 with valid data updates the message" do
      message = message_fixture()
      update_attrs = %{message: "some updated message", room_id: 43, user_id: 43}

      assert {:ok, %Message{} = message} = Messages.update_message(message, update_attrs)
      assert message.message == "some updated message"
      assert message.room_id == 43
      assert message.user_id == 43
    end

    test "update_message/2 with invalid data returns error changeset" do
      message = message_fixture()
      assert {:error, %Ecto.Changeset{}} = Messages.update_message(message, @invalid_attrs)
      assert message == Messages.get_message!(message.id)
    end

    test "delete_message/1 deletes the message" do
      message = message_fixture()
      assert {:ok, %Message{}} = Messages.delete_message(message)
      assert_raise Ecto.NoResultsError, fn -> Messages.get_message!(message.id) end
    end

    test "change_message/1 returns a message changeset" do
      message = message_fixture()
      assert %Ecto.Changeset{} = Messages.change_message(message)
    end
  end
end

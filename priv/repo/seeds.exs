# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Fuzzychat.Repo.insert!(%Fuzzychat.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Fuzzychat.Repo
alias Fuzzychat.Rooms.Room

%Room{
  name: "General",
  description: "General chat room"
}
|> Repo.insert!()

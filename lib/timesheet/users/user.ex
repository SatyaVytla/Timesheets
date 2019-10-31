defmodule Timesheet.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :ismanager, :boolean, default: false
    field :password, :string
    field :user_name, :string
    field :manager_id, :integer

    #belongs_to :logsheets, Timesheet.Logsheets.Logsheet
    has_many :logsheets, Timesheet.Logsheets.Logsheet
    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:user_name, :password, :ismanager])
    |> validate_required([:user_name, :password, :ismanager])
  end
end

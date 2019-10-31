defmodule Timesheet.Logsheets.Logsheet do
  use Ecto.Schema
  import Ecto.Changeset

  schema "logsheets" do
    #field :date_logged, :date
    field :hours, :integer
    #field :job_code, :string
    field :task_seqno, :integer
    #field :user_id, :integer

    belongs_to :jobs, Timesheet.Jobs.Job, foreign_key: :job_code, type: :string
    belongs_to :user, Timesheet.Users.User
    belongs_to :trackers, Timesheet.Trackers.Tracker, foreign_key: :date_logged, type: :date
    timestamps()
  end

  @doc false
  def changeset(logsheet, attrs) do
    logsheet
    |> cast(attrs, [:date_logged, :task_seqno, :hours, :user_id, :job_code])
    |> validate_required([:date_logged, :task_seqno, :hours, :user_id, :job_code])
  end
end

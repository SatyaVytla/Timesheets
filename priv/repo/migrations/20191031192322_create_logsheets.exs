defmodule Timesheet.Repo.Migrations.CreateLogsheets do
  use Ecto.Migration

  def change do
    create table(:logsheets) do

      add :task_seqno, :integer
      add :hours, :integer

      add :job_code, references(:jobs, column: :job_code, type: :string)
      add :user_id, references(:users)
      add :date_logged, references(:trackers, column: :date_logged, type: :date)

      timestamps()
    end

  end
end

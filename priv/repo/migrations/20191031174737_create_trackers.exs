defmodule Timesheet.Repo.Migrations.CreateTrackers do
  use Ecto.Migration

  def change do
    create table(:trackers, primary_key: false) do
      add :timesheet_id, :integer
      add :date_logged, :date, primary_key: true

      timestamps()
    end

  end
end

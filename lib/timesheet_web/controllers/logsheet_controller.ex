defmodule TimesheetWeb.LogsheetController do
  use TimesheetWeb, :controller

  alias Timesheet.Logsheets
  alias Timesheet.Logsheets.Logsheet

  def index(conn, _params) do
    logsheets = Logsheets.list_logsheets()
    render(conn, "index.html", logsheets: logsheets)
  end

  def new(conn, _params) do
    changeset = Logsheets.change_logsheet(%Logsheet{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"logsheet" => logsheet_params}) do
    case Logsheets.create_logsheet(logsheet_params) do
      {:ok, logsheet} ->
        conn
        |> put_flash(:info, "Logsheet created successfully.")
        |> redirect(to: Routes.logsheet_path(conn, :show, logsheet))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    logsheet = Logsheets.get_logsheet!(id)
    render(conn, "show.html", logsheet: logsheet)
  end

  def edit(conn, %{"id" => id}) do
    logsheet = Logsheets.get_logsheet!(id)
    changeset = Logsheets.change_logsheet(logsheet)
    render(conn, "edit.html", logsheet: logsheet, changeset: changeset)
  end

  def update(conn, %{"id" => id, "logsheet" => logsheet_params}) do
    logsheet = Logsheets.get_logsheet!(id)

    case Logsheets.update_logsheet(logsheet, logsheet_params) do
      {:ok, logsheet} ->
        conn
        |> put_flash(:info, "Logsheet updated successfully.")
        |> redirect(to: Routes.logsheet_path(conn, :show, logsheet))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", logsheet: logsheet, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    logsheet = Logsheets.get_logsheet!(id)
    {:ok, _logsheet} = Logsheets.delete_logsheet(logsheet)

    conn
    |> put_flash(:info, "Logsheet deleted successfully.")
    |> redirect(to: Routes.logsheet_path(conn, :index))
  end
end

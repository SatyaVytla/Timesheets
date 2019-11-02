defmodule TimesheetWeb.LogsheetController do
  use TimesheetWeb, :controller

  alias Timesheet.Logsheets
  alias Timesheet.Logsheets.Logsheet

  alias Timesheet.Jobs
  alias Timesheet.Jobs.Job

  def index(conn, _params) do
    logsheets = Logsheets.list_logsheets()
    render(conn, "index.html", logsheets: logsheets)
  end

  def new(conn, params) do
    changeset = Logsheets.change_logsheet(%Logsheet{})
    jobs = Jobs.get_jobcodes()
    date= params["date_selected"]
    {year, ""} = Integer.parse(date["year"])
    {month, ""} = Integer.parse(date["month"])
    {day, ""} = Integer.parse(date["day"])
    date_creation = Date.new(year,month,day)
    {ok,date_logged} = date_creation
    render(conn, "new.html", changeset: changeset, jobs: jobs, date_logged: date_logged)
  end

  def create(conn, %{"logsheet" => logsheet_params}) do
    IO.puts("con")
    IO.inspect(conn)
    numbers = 1..8
    iterList = Enum.to_list(numbers)
    Enum.map(iterList, fn x ->
      insertMap = %{}
      value1 = logsheet_params[":hours#{x}"]
      value2 = logsheet_params[":job#{x}"]
      insertMap= Map.put(insertMap,"hours", value1)
      insertMap= Map.put(insertMap,"job_code", value2)
      insertMap= Map.put(insertMap,"user_id", conn.assigns[:current_user].id)
      date= logsheet_params["date_logged"]
      {year, ""} = Integer.parse(date["year"])
      {month, ""} = Integer.parse(date["month"])
      {day, ""} = Integer.parse(date["day"])
      date_creation = Date.new(year,month,day)
      {ok,date_logged} = date_creation

      insertMap= Map.put(insertMap,"date_logged", date_logged)

      resp = Logsheets.create_logsheet(insertMap)
      IO.inspect(resp)
    end)
    logsheet_params = Map.put(logsheet_params, "user_id", conn.assigns[:current_user].id)
    jobs = Jobs.get_jobcodes()
    case Logsheets.create_logsheet(logsheet_params) do
      {:ok, logsheet} ->
        conn
        |> put_flash(:info, "Logsheet created successfully.")
        |> redirect(to: Routes.logsheet_path(conn, :show, logsheet))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, jobs: jobs)
    end
  end

  def show(conn, params) do
   # logsheet = Logsheets.get_logsheet!(id)
    IO.puts("show")
    user_id = params["user_id"]
    date= params["date"]
    {year, ""} = Integer.parse(date["year"])
    {month, ""} = Integer.parse(date["month"])
    {day, ""} = Integer.parse(date["day"])
    date_creation = Date.new(year,month,day)
    {ok,date} = date_creation
    IO.inspect(date)

   render(conn, "show.html", date: date, user_id: user_id)
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

defmodule Timesheet.Logsheets do
  @moduledoc """
  The Logsheets context.
  """

  import Ecto.Query, warn: false
  alias Timesheet.Repo

  alias Timesheet.Logsheets.Logsheet

  @doc """
  Returns the list of logsheets.

  ## Examples

      iex> list_logsheets()
      [%Logsheet{}, ...]

  """
  def list_logsheets do
    Repo.all(Logsheet)
  end

  @doc """
  Gets a single logsheet.

  Raises `Ecto.NoResultsError` if the Logsheet does not exist.

  ## Examples

      iex> get_logsheet!(123)
      %Logsheet{}

      iex> get_logsheet!(456)
      ** (Ecto.NoResultsError)

  """
  def get_logsheet!(id), do: Repo.get!(Logsheet, id)

  @doc """
  Creates a logsheet.

  ## Examples

      iex> create_logsheet(%{field: value})
      {:ok, %Logsheet{}}

      iex> create_logsheet(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_logsheet(attrs \\ %{}) do
    IO.puts("--------------------------------------------")
    %Logsheet{}
    |> Logsheet.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a logsheet.

  ## Examples

      iex> update_logsheet(logsheet, %{field: new_value})
      {:ok, %Logsheet{}}

      iex> update_logsheet(logsheet, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_logsheet(%Logsheet{} = logsheet, attrs) do
    logsheet
    |> Logsheet.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Logsheet.

  ## Examples

      iex> delete_logsheet(logsheet)
      {:ok, %Logsheet{}}

      iex> delete_logsheet(logsheet)
      {:error, %Ecto.Changeset{}}

  """
  def delete_logsheet(%Logsheet{} = logsheet) do
    Repo.delete(logsheet)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking logsheet changes.

  ## Examples

      iex> change_logsheet(logsheet)
      %Ecto.Changeset{source: %Logsheet{}}

  """
  def change_logsheet(%Logsheet{} = logsheet) do
    Logsheet.changeset(logsheet, %{})
  end
end

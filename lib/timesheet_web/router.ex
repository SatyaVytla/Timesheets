defmodule TimesheetWeb.Router do
  use TimesheetWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_session
    plug TimesheetWeb.Plugs.FetchCurrentUser
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TimesheetWeb do
    pipe_through :browser

    get "/", PageController, :index
    post "/user_pages", PageController, :user_pages
    get "/update_task", LogsheetController, :update_task

    resources "/users", UserController
    resources "/jobs", JobController
    resources "/trackers", TrackerController
    resources "/logsheets", LogsheetController

    resources "/sessions", SessionController,
              only: [:new, :create, :delete], singleton: true

  end

  # Other scopes may use custom stacks.
  # scope "/api", TimesheetWeb do
  #   pipe_through :api
  # end
end

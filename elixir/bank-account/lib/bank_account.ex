defmodule BankAccount do
  @moduledoc """
  A bank account that supports access from multiple processes.
  """
  @type account_closed_error :: {:error, :account_closed}

  defmacrop on_account_exists(account, do: expression) do
    quote do
      if Process.alive?(unquote(account)) do
        unquote(expression)
      else
        {:error, :account_closed}
      end
    end
  end

  @typedoc """
  An account handle.
  """
  @opaque account :: pid

  @doc """
  Open the bank. Makes the account available.
  """
  @spec open_bank() :: account
  def open_bank() do
    {:ok, pid} = Agent.start_link(fn -> 0 end)

    pid
  end

  @doc """
  Close the bank. Makes the account unavailable.
  """
  @spec close_bank(account) :: :ok | account_closed_error
  def close_bank(account) do
    on_account_exists account do
      Agent.stop(account)
    end
  end

  @doc """
  Get the account's balance.
  """
  @spec balance(account) :: integer | account_closed_error
  def balance(account) do
    on_account_exists account do
      Agent.get(account, fn balance -> balance end)
    end
  end

  @doc """
  Update the account's balance by adding the given amount which may be negative.
  """
  @spec update(account, integer) :: :ok | account_closed_error()
  def update(account, amount) do
    on_account_exists account do
      Agent.update(account, fn balance -> balance + amount end)
    end
  end
end

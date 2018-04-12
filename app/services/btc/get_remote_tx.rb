module Btc
  class GetRemoteTx

    extend LightService::Action
    expects :bitcoiner_client, :tx_id
    promises :remote_tx
    VERBOSE = true

    executed do |c|
      c.remote_tx = c.bitcoiner_client.
        request("getrawtransaction", c.tx_id, VERBOSE)
    end

  end
end

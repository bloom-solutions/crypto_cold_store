module Btc
  class GetRemoteBlocks

    extend LightService::Action
    expects :bitcoiner_client, :block_hashes
    promises :remote_blocks
    VERBOSITY = 2.freeze

    executed do |c|
      args = c.block_hashes.map do |block_hash|
        ["getblock", [block_hash, VERBOSITY]]
      end

      response = BitcoindCircuit.run_on_context(c) do
        c.bitcoiner_client.request(args)
      end

      c.remote_blocks = response.map { |hash| hash["result"] }.compact
    end

  end
end

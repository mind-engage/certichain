import { useAccount, useConnect, useDisconnect } from "wagmi";
import { InjectedConnector } from "wagmi/connectors/injected";

export default function WalletConnectButton() {
  const { address, isConnected } = useAccount();
  const { connect } = useConnect({ connector: new InjectedConnector() });
  const { disconnect } = useDisconnect();

  if (isConnected)
    return (
      <button className="btn" onClick={() => disconnect()}>
        Disconnect {address?.slice(0, 6)}…
      </button>
    );
  return (
    <button className="btn" onClick={() => connect()}>
      Connect Wallet
    </button>
  );
}
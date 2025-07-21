import { WagmiConfig, createConfig, sepolia, polygon, polygonAmoy, configureChains, http } from "wagmi";
import { publicProvider } from "wagmi/providers/public";
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import "../styles.css";

const { chains, publicClient } = configureChains(
  [polygonAmoy],
  [publicProvider()]
);

const config = createConfig({ autoConnect: true, publicClient });
const queryClient = new QueryClient();

export default function App({ Component, pageProps }) {
  return (
    <QueryClientProvider client={queryClient}>
      <WagmiConfig config={config}>
        <Component {...pageProps} />
      </WagmiConfig>
    </QueryClientProvider>
  );
}
import WalletConnectButton from "../components/WalletConnectButton";
import Link from "next/link";

export default function Home() {
  return (
    <main className="container mx-auto p-4">
      <h1 className="text-3xl font-bold mb-4">CertiChain</h1>
      <WalletConnectButton />
      <div className="mt-8 flex gap-4">
        <Link href="/exams" className="btn-primary">Browse Exams</Link>
        <Link href="/verify" className="btn-secondary">Verify Certificate</Link>
      </div>
    </main>
  );
}
import { useContractRead, useAccount } from "wagmi";
import abi from "../abi/ExamRegistry.json";

export default function Exams() {
  const { address } = useAccount();
  const { data: count } = useContractRead({
    address: process.env.NEXT_PUBLIC_REGISTRY as `0x${string}`,
    abi,
    functionName: "getExamCount",
  });
  return (
    <main className="p-4">
      <h2 className="text-xl font-bold mb-4">Available Exams ({Number(count)})</h2>
      {/* Map exam cards here */}
      {!address && <p>Please connect wallet.</p>}
    </main>
  );
}
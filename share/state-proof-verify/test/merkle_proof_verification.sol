// SPDX-License-Identifier: MIT OR Apache-2.0
//---------------------------------------------------------------------------//
// Copyright (c) 2021 Mikhail Komarov <nemo@nil.foundation>
// Copyright (c) 2021 Ilias Khairullin <ilias@nil.foundation>
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//---------------------------------------------------------------------------//

pragma solidity >=0.8.4;
pragma experimental ABIEncoderV2;

import "truffle/Assert.sol";
import '../contracts/containers/merkle_verifier.sol';

contract TestMerkleProofVerifier {
    function test_merkle_proof_verifier() public {
        // tree depth = 5
        bytes memory raw_proof = hex"0000000000000005000000000000002059cba3bdcfcfdcabe6bc23802966d76367c28a7939fb39f8432620ec466aabaf0000000000000005000000000000000100000000000000000000000000000020fd9445ad175f8f3a6405eaaf5fd583873d3f5d0c903da0aeb97b04fac7fcbcc80000000000000001000000000000000100000000000000204a5e9e2000650fa7d168a06809478bbcb469532092887806f21d7cd074d96905000000000000000100000000000000000000000000000020b0e647e0624a38eeb146c44762a79021f3864d12abd3342fd6edde51f304db850000000000000001000000000000000100000000000000205ca0b18db54a196413a95df26ef750b03adba1e2f0bc08a976545f9cfa83481d0000000000000001000000000000000100000000000000206e0184836cd6eaedf595e70cfb97d83d2d261c987b86f937e0877235ac259abc";
        bytes32 verified_data = hex"8107f390abb06908493732a40062b18e3894e0d191b091b273b584cdc6fbd547";
        (types.merkle_proof memory proof, uint256 proof_size) = merkle_verifier.parse_merkle_proof_be(raw_proof, 0);
        Assert.equal(raw_proof.length, proof_size, "Proof length is not correct");
        Assert.equal(true, merkle_verifier.verify_merkle_proof(proof, verified_data), "Proof is not correct");
        Assert.equal(raw_proof.length, merkle_verifier.skip_merkle_proof_be(raw_proof, 0), "Skipping proof is not correct!");

        // tree depth = 5
        raw_proof = hex"000000000000000400000000000000209ef532c8ff14797df5fc0bf9e8cb2b840f193ec98fbbcd21b1ef07c7954751d40000000000000005000000000000000100000000000000010000000000000020b9437b39e058fb05fb04926d5b1d54bfe46d0e3b164d68f6f4cba33790a597a3000000000000000100000000000000010000000000000020e4aca3407ae184c24b3d385cf72ce11d7bb4cd2f332501a6b70c518870c6061a00000000000000010000000000000000000000000000002023bce05bcd106222c88a3d113bec431944e514095f21d9496433dba2ed5b7444000000000000000100000000000000010000000000000020595f258e9b2af1c4b9a1295f5eb4ac47389c609c76fad2dd05f3a68231940c0f000000000000000100000000000000010000000000000020d63e5dfe357c2cc7abc11de4a36d582d4976503aa64727b076ca5e5278a7c60f";
        verified_data = hex"edd460afda1dc56b4dcceff9e8be90769b65b75e951fd6f2efbf29aa77f3ac64";
        (proof, proof_size) = merkle_verifier.parse_merkle_proof_be(raw_proof, 0);
        Assert.equal(raw_proof.length, proof_size, "Proof length is not correct");
        Assert.equal(true, merkle_verifier.verify_merkle_proof(proof, verified_data), "Proof is not correct");
        Assert.equal(raw_proof.length, merkle_verifier.skip_merkle_proof_be(raw_proof, 0), "Skipping proof is not correct!");

        // tree depth = 7
        raw_proof = hex"000000000000001100000000000000209e28ec2b409a41cbf5a5990a07a6a9ad3cd1dc9f9ce77cc72951a622079357a600000000000000070000000000000001000000000000000000000000000000200a4beb96a289a55f23bfc0a4c8ab5de2785c4e35e809604e54a9c906410a79090000000000000001000000000000000100000000000000208e219da278bd67eeede6496895074bcb2eb0949cdc8f87df20bf1ff5db922ae5000000000000000100000000000000010000000000000020c5b462d2893b66ededc3ca670da8edf91f5628fb0cb2454ec93337706bc4a6570000000000000001000000000000000100000000000000201cce82f07342e67c7841e7f66e30051df3c18a73441a60ba0262005f39c3826e000000000000000100000000000000000000000000000020b88d9f2df4f93ec23455de4d71fc4629b7c2fe177050922c4518c4644863aa0500000000000000010000000000000001000000000000002094551b73d824e0e13bb1cb0e0a04bf170d53433e542e41a20a77a2a359f1082f0000000000000001000000000000000100000000000000200789fe29b24baa0d0b785310bfe56ce147feba253bd71565d18a79b59398147a";
        verified_data = hex"358e1c765ef0611ae414d9eab502a2cf4cc13f30782d619a82edb479c7f520fc";
        (proof, proof_size) = merkle_verifier.parse_merkle_proof_be(raw_proof, 0);
        Assert.equal(raw_proof.length, proof_size, "Proof length is not correct");
        Assert.equal(true, merkle_verifier.verify_merkle_proof(proof, verified_data), "Proof is not correct");
        Assert.equal(raw_proof.length, merkle_verifier.skip_merkle_proof_be(raw_proof, 0), "Skipping proof is not correct!");

        // tree depth = 8
        raw_proof = hex"00000000000000d700000000000000200f866a147528c0d18b50f5a56768c0329f41aca3a57423c356ddaedef20e256a0000000000000008000000000000000100000000000000000000000000000020434c2ced0172549c8537bbde2460778e88997f96f05d25f62188ec0080965034000000000000000100000000000000000000000000000020c15a62703fb876ce99af59c47ef726cbb06111051b3fd3d39d9a04851e831de1000000000000000100000000000000000000000000000020e6cc067eb506683b2fe8d266d14d4dddffcf3d3f54ba9ca1630842a612260a1900000000000000010000000000000001000000000000002001454e65dfe583abfdac1c3be255268fd937158b38a3f243b7fd5e82f81a69b40000000000000001000000000000000000000000000000202d9d27070d4d943a43e7928d7932a4d33c6be3e86e3e69516e0938362c149e320000000000000001000000000000000100000000000000208a00a1f9488d96cd2d93dc579dedb6812ec7e213987c8bf1c9c7e8d4bae0c19500000000000000010000000000000000000000000000002035690cab856af2ca815218b32e3d05888c207c238b9a09ee690d8789a469c1000000000000000001000000000000000000000000000000202e70caf956424b025a9b4391e12a22b9ac1c1929ad6c8247a1bf7fee97ec9e84";
        verified_data = hex"994a6ed2581783fe1755b39e598d67215076bb29d662932a8a4e8448358cd3cf";
        (proof, proof_size) = merkle_verifier.parse_merkle_proof_be(raw_proof, 0);
        Assert.equal(raw_proof.length, proof_size, "Proof length is not correct");
        Assert.equal(true, merkle_verifier.verify_merkle_proof(proof, verified_data), "Proof is not correct");
        Assert.equal(raw_proof.length, merkle_verifier.skip_merkle_proof_be(raw_proof, 0), "Skipping proof is not correct!");

        // tree depth = 10
        raw_proof = hex"000000000000035a0000000000000020397f039abb6820c4c0672cf0dde0f2446907c4c2ab705fac228873cf0d053c5b000000000000000a000000000000000100000000000000010000000000000020e2c7769ccd2904ed12ca56b3111650b7ae387145ac8c2952bfa00ca7606a7e0d000000000000000100000000000000000000000000000020443aeeb1c60a56aa3ed4bb5c6ccc09df4dc6f4a51dec83c186f1e9db27242c1b000000000000000100000000000000010000000000000020d552e3e4b57460bd4d690e6c30dd45dab31a1a30a2b60c7d215a6d98d0d22ef000000000000000010000000000000000000000000000002020a6c740b97b007fad3f593f5547f4b2bfa5f4510ca990acc9d845efd5ae895d000000000000000100000000000000000000000000000020bdf18fc04e5b5a1474dfeab810e5db06d303b32bbca65022fd560e2d4ef60e050000000000000001000000000000000100000000000000200de044d0d41415683b0c92eb30f9192a2ff5a050f0ef858f74a54fa0550a3cb3000000000000000100000000000000000000000000000020fbfdd0dde410df07e59f028885f0e4a1038f57bb9c8681f9a0a16bb795f756a80000000000000001000000000000000100000000000000203f1a01d93e4a77b4958cadbb0fb2805d649748a42e4f4e9e4704aed152ab65b000000000000000010000000000000000000000000000002078ac3161b9d6d203276113fc9dd0fb0980c981b41537f1795b4d8d6309cd837800000000000000010000000000000000000000000000002084406109ae49701ee36c49c0d2326b1d92d19ef10b9bb651d12966d93423a9f5";
        verified_data = hex"07616f393738ae85bcec7fc3661dc7d2b5d1ecc4f3ccef810e02b6aa67592b6f";
        (proof, proof_size) = merkle_verifier.parse_merkle_proof_be(raw_proof, 0);
        Assert.equal(raw_proof.length, proof_size, "Proof length is not correct");
        Assert.equal(true, merkle_verifier.verify_merkle_proof(proof, verified_data), "Proof is not correct");
        Assert.equal(raw_proof.length, merkle_verifier.skip_merkle_proof_be(raw_proof, 0), "Skipping proof is not correct!");
    }

    function test_merkle_proof_verifier_on_byteblob() public {
        // tree depth = 5
        bytes memory raw_proof = hex"0000000000000005000000000000002059cba3bdcfcfdcabe6bc23802966d76367c28a7939fb39f8432620ec466aabaf0000000000000005000000000000000100000000000000000000000000000020fd9445ad175f8f3a6405eaaf5fd583873d3f5d0c903da0aeb97b04fac7fcbcc80000000000000001000000000000000100000000000000204a5e9e2000650fa7d168a06809478bbcb469532092887806f21d7cd074d96905000000000000000100000000000000000000000000000020b0e647e0624a38eeb146c44762a79021f3864d12abd3342fd6edde51f304db850000000000000001000000000000000100000000000000205ca0b18db54a196413a95df26ef750b03adba1e2f0bc08a976545f9cfa83481d0000000000000001000000000000000100000000000000206e0184836cd6eaedf595e70cfb97d83d2d261c987b86f937e0877235ac259abc";
        bytes32 verified_data = hex"8107f390abb06908493732a40062b18e3894e0d191b091b273b584cdc6fbd547";
        (bool result, uint256 merkle_proof_size) = merkle_verifier.parse_verify_merkle_proof_be(raw_proof, 0, verified_data);
        Assert.equal(raw_proof.length, merkle_proof_size, "Proof length is not correct!");
        Assert.equal(true, result, "Proof is not correct!");
        Assert.equal(raw_proof.length, merkle_verifier.skip_merkle_proof_be(raw_proof, 0), "Skipping proof is not correct!");

        // tree depth = 5
        raw_proof = hex"000000000000000400000000000000209ef532c8ff14797df5fc0bf9e8cb2b840f193ec98fbbcd21b1ef07c7954751d40000000000000005000000000000000100000000000000010000000000000020b9437b39e058fb05fb04926d5b1d54bfe46d0e3b164d68f6f4cba33790a597a3000000000000000100000000000000010000000000000020e4aca3407ae184c24b3d385cf72ce11d7bb4cd2f332501a6b70c518870c6061a00000000000000010000000000000000000000000000002023bce05bcd106222c88a3d113bec431944e514095f21d9496433dba2ed5b7444000000000000000100000000000000010000000000000020595f258e9b2af1c4b9a1295f5eb4ac47389c609c76fad2dd05f3a68231940c0f000000000000000100000000000000010000000000000020d63e5dfe357c2cc7abc11de4a36d582d4976503aa64727b076ca5e5278a7c60f";
        verified_data = hex"edd460afda1dc56b4dcceff9e8be90769b65b75e951fd6f2efbf29aa77f3ac64";
        (result, merkle_proof_size) = merkle_verifier.parse_verify_merkle_proof_be(raw_proof, 0, verified_data);
        Assert.equal(raw_proof.length, merkle_proof_size, "Proof length is not correct!");
        Assert.equal(true, result, "Proof is not correct!");
        Assert.equal(raw_proof.length, merkle_verifier.skip_merkle_proof_be(raw_proof, 0), "Skipping proof is not correct!");

        // tree depth = 7
        raw_proof = hex"000000000000001100000000000000209e28ec2b409a41cbf5a5990a07a6a9ad3cd1dc9f9ce77cc72951a622079357a600000000000000070000000000000001000000000000000000000000000000200a4beb96a289a55f23bfc0a4c8ab5de2785c4e35e809604e54a9c906410a79090000000000000001000000000000000100000000000000208e219da278bd67eeede6496895074bcb2eb0949cdc8f87df20bf1ff5db922ae5000000000000000100000000000000010000000000000020c5b462d2893b66ededc3ca670da8edf91f5628fb0cb2454ec93337706bc4a6570000000000000001000000000000000100000000000000201cce82f07342e67c7841e7f66e30051df3c18a73441a60ba0262005f39c3826e000000000000000100000000000000000000000000000020b88d9f2df4f93ec23455de4d71fc4629b7c2fe177050922c4518c4644863aa0500000000000000010000000000000001000000000000002094551b73d824e0e13bb1cb0e0a04bf170d53433e542e41a20a77a2a359f1082f0000000000000001000000000000000100000000000000200789fe29b24baa0d0b785310bfe56ce147feba253bd71565d18a79b59398147a";
        verified_data = hex"358e1c765ef0611ae414d9eab502a2cf4cc13f30782d619a82edb479c7f520fc";
        (result, merkle_proof_size) = merkle_verifier.parse_verify_merkle_proof_be(raw_proof, 0, verified_data);
        Assert.equal(raw_proof.length, merkle_proof_size, "Proof length is not correct!");
        Assert.equal(true, result, "Proof is not correct!");
        Assert.equal(raw_proof.length, merkle_verifier.skip_merkle_proof_be(raw_proof, 0), "Skipping proof is not correct!");

        // tree depth = 8
        raw_proof = hex"00000000000000d700000000000000200f866a147528c0d18b50f5a56768c0329f41aca3a57423c356ddaedef20e256a0000000000000008000000000000000100000000000000000000000000000020434c2ced0172549c8537bbde2460778e88997f96f05d25f62188ec0080965034000000000000000100000000000000000000000000000020c15a62703fb876ce99af59c47ef726cbb06111051b3fd3d39d9a04851e831de1000000000000000100000000000000000000000000000020e6cc067eb506683b2fe8d266d14d4dddffcf3d3f54ba9ca1630842a612260a1900000000000000010000000000000001000000000000002001454e65dfe583abfdac1c3be255268fd937158b38a3f243b7fd5e82f81a69b40000000000000001000000000000000000000000000000202d9d27070d4d943a43e7928d7932a4d33c6be3e86e3e69516e0938362c149e320000000000000001000000000000000100000000000000208a00a1f9488d96cd2d93dc579dedb6812ec7e213987c8bf1c9c7e8d4bae0c19500000000000000010000000000000000000000000000002035690cab856af2ca815218b32e3d05888c207c238b9a09ee690d8789a469c1000000000000000001000000000000000000000000000000202e70caf956424b025a9b4391e12a22b9ac1c1929ad6c8247a1bf7fee97ec9e84";
        verified_data = hex"994a6ed2581783fe1755b39e598d67215076bb29d662932a8a4e8448358cd3cf";
        (result, merkle_proof_size) = merkle_verifier.parse_verify_merkle_proof_be(raw_proof, 0, verified_data);
        Assert.equal(raw_proof.length, merkle_proof_size, "Proof length is not correct!");
        Assert.equal(true, result, "Proof is not correct!");
        Assert.equal(raw_proof.length, merkle_verifier.skip_merkle_proof_be(raw_proof, 0), "Skipping proof is not correct!");

        // tree depth = 10
        raw_proof = hex"000000000000035a0000000000000020397f039abb6820c4c0672cf0dde0f2446907c4c2ab705fac228873cf0d053c5b000000000000000a000000000000000100000000000000010000000000000020e2c7769ccd2904ed12ca56b3111650b7ae387145ac8c2952bfa00ca7606a7e0d000000000000000100000000000000000000000000000020443aeeb1c60a56aa3ed4bb5c6ccc09df4dc6f4a51dec83c186f1e9db27242c1b000000000000000100000000000000010000000000000020d552e3e4b57460bd4d690e6c30dd45dab31a1a30a2b60c7d215a6d98d0d22ef000000000000000010000000000000000000000000000002020a6c740b97b007fad3f593f5547f4b2bfa5f4510ca990acc9d845efd5ae895d000000000000000100000000000000000000000000000020bdf18fc04e5b5a1474dfeab810e5db06d303b32bbca65022fd560e2d4ef60e050000000000000001000000000000000100000000000000200de044d0d41415683b0c92eb30f9192a2ff5a050f0ef858f74a54fa0550a3cb3000000000000000100000000000000000000000000000020fbfdd0dde410df07e59f028885f0e4a1038f57bb9c8681f9a0a16bb795f756a80000000000000001000000000000000100000000000000203f1a01d93e4a77b4958cadbb0fb2805d649748a42e4f4e9e4704aed152ab65b000000000000000010000000000000000000000000000002078ac3161b9d6d203276113fc9dd0fb0980c981b41537f1795b4d8d6309cd837800000000000000010000000000000000000000000000002084406109ae49701ee36c49c0d2326b1d92d19ef10b9bb651d12966d93423a9f5";
        verified_data = hex"07616f393738ae85bcec7fc3661dc7d2b5d1ecc4f3ccef810e02b6aa67592b6f";
        (result, merkle_proof_size) = merkle_verifier.parse_verify_merkle_proof_be(raw_proof, 0, verified_data);
        Assert.equal(raw_proof.length, merkle_proof_size, "Proof length is not correct!");
        Assert.equal(true, result, "Proof is not correct!");
        Assert.equal(raw_proof.length, merkle_verifier.skip_merkle_proof_be(raw_proof, 0), "Skipping proof is not correct!");
    }
}

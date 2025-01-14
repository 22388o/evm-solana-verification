// SPDX-License-Identifier: Apache-2.0.
//---------------------------------------------------------------------------//
// Copyright (c) 2022 Mikhail Komarov <nemo@nil.foundation>
// Copyright (c) 2022 Ilias Khairullin <ilias@nil.foundation>
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

library basic_marshalling {
    uint256 constant LENGTH_OCTETS = 8;
    // 256 - 8 * LENGTH_OCTETS
    uint256 constant LENGTH_RESTORING_SHIFT = 0xc0;

    // TODO: general case
    function skip_octet_vector_32_be(bytes memory blob, uint256 offset)
    internal pure returns (uint256 result_offset) {
        result_offset = offset + LENGTH_OCTETS + 32;
        require(result_offset <= blob.length);
    }

    // TODO: general case
    function skip_vector_of_octet_vectors_32_be(bytes memory blob, uint256 offset)
    internal pure returns (uint256 result_offset) {
        require(offset < blob.length);

        require(LENGTH_OCTETS <= blob.length - offset);
        uint256 elements_n;
        assembly {
            elements_n := shr(LENGTH_RESTORING_SHIFT, mload(add(add(blob, 0x20), offset)))
        }

        result_offset = offset + LENGTH_OCTETS + elements_n * (LENGTH_OCTETS + 32);
        require(result_offset <= blob.length);
    }

    function skip_uint256_be(bytes memory blob, uint256 offset)
    internal pure returns (uint256 result_offset) {
        result_offset = offset + 32;
        require(result_offset <= blob.length);
    }

    function skip_vector_of_uint256_be(bytes memory blob, uint256 offset)
    internal pure returns (uint256 result_offset) {
        require(offset < blob.length);

        require(LENGTH_OCTETS <= blob.length - offset);
        uint256 elements_n;
        assembly {
            elements_n := shr(LENGTH_RESTORING_SHIFT, mload(add(add(blob, 0x20), offset)))
        }

        result_offset = offset + LENGTH_OCTETS + elements_n * 32;
        require(result_offset <= blob.length);
    }

    function skip_length(bytes memory blob, uint256 offset)
    internal pure returns (uint256 result_offset) {
        result_offset = offset + LENGTH_OCTETS;
        require(result_offset < blob.length);
    }

    function get_length(bytes memory blob, uint256 offset)
    internal pure returns (uint256 result_length) {
        require(offset < blob.length);

        require(LENGTH_OCTETS <= blob.length - offset);
        assembly {
            result_length := shr(LENGTH_RESTORING_SHIFT, mload(add(add(blob, 0x20), offset)))
        }
    }

    function get_skip_length(bytes memory blob, uint256 offset)
    internal pure returns (uint256 result_length, uint256 result_offset) {
        require(offset < blob.length);

        require(LENGTH_OCTETS <= blob.length - offset);
        assembly {
            result_length := shr(LENGTH_RESTORING_SHIFT, mload(add(add(blob, 0x20), offset)))
        }
        result_offset = offset + LENGTH_OCTETS;
    }

    function get_i_uint256_from_vector(bytes memory blob, uint256 offset, uint256 i)
    internal pure returns (uint256 result) {
        assembly {
            result := mload(add(
                add(blob, 0x20),
                add(add(offset, LENGTH_OCTETS), mul(i, 0x20))
            ))
        }
    }

    function get_uint256_be(bytes memory blob, uint256 offset)
    internal pure returns (uint256 result) {
        assembly {
            result := mload(add(
                add(blob, 0x20),
                offset
            ))
        }
    }

}

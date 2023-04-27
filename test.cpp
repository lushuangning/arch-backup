int VideoEncoderAdapter::fill_sei_packet_in_h265(unsigned char *packet, int isAnnexb, const char *content, uint32_t size){
    unsigned char *data = packet;
    uint32_t total_size = 0;

    // NAL unit header
    uint8_t nuh_reserved_zero_bits = 0;
    uint8_t nuh_layer_id = 0;
    uint8_t nuh_temporal_id_plus1 = 1;
    uint8_t nal_unit_header = (NAL_SEI_PREFIX << 1) | nuh_reserved_zero_bits;

    // nalu 的header，start_code
    *data++ = 0x00;
    *data++ = 0x00;
    *data++ = 0x00;
    *data++ = 0x01;

    // 设置type 为sei的类型
    *data++ = nal_unit_header;
    *data++ = nuh_layer_id << 5 | nuh_temporal_id_plus1 - 1;

    // SEI payload
    uint32_t sei_payload_type = 5;  // unregistered
    uint32_t sei_payload_size = size + UUID_SIZE + 2;
    // 依次使用字节表示sei_payload_size的大小
    while (sei_payload_size > 0xFF) {
        *data++ = 0xFF;
        sei_payload_size -= 0xFF;
        total_size++;
    }
    *data++ = sei_payload_size;
    total_size++;
//    uint32_t sei_payload_size = size + UUID_SIZE + 2;  // 2 是指 SEI payload header 的大小
//    if (sei_payload_size > 0xFFFF) {
//        sei_payload_size = 0xFFFF;  // 如果超过最大值，则截断
//    }
//    *data++ = (sei_payload_size >> 8) & 0xFF;
//    *data++ = sei_payload_size & 0xFF;
//    total_size += 2;

    // 将sei_payload_header 的高位，中位和低位分别写入三个字节中
    uint32_t sei_payload_header = sei_payload_type << 16 | sei_payload_size;
    *data++ = (sei_payload_header >> 16) & 0xFF;
    *data++ = (sei_payload_header >> 8) & 0xFF;
    *data++ = sei_payload_header & 0xFF;
    total_size += 4;

    // UUID
    memcpy(data, uuid, UUID_SIZE);
    data += UUID_SIZE;
    total_size += UUID_SIZE;

    // Data
    size += 4;
    memcpy(data, content, size);
    data += size;
    total_size += size;

    //Annex B trailing zero bytes
    int num_zero_bytes = 0;
    while (*(data - 1) == 0x00) {
        num_zero_bytes++;
    }
    if (*(data - 1) == 0x01) {
        num_zero_bytes--;
    }
    for (int i = 0; i < num_zero_bytes + 1; i++) {
        *data++ = 0x00;
        total_size++;
    }

    return total_size;
}

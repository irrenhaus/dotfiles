Vim�UnDo� ����U�R��^��3 4�h2�9�ȝ���C      "PINENOTE_IP=${IP:-192.168.178.110}            -       -   -   -    a�    _�                             ����                                                                                                                                                                                                                                                                                                                                                             a���     �                   5��                                                  �                                              �                                              �                                              �                                              �                                              �                                                �                                                �                                                5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             a���     �                 OUTPUT_DIR=5��                                              �                                              �                                              5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             a���     �                 OUTPUT_DIR=""5��                                              5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             a���     �                 OUTPUT_DIR=""5��                                              �                                              �                                              �                                               5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             a���     �                 OUTPUT_DIR="``"5��                                              �                                             �                                             �                                             �                                             �                                             �                                             �                                             �                                             �                     	                 	       �              	       
          	       
       �              
       
          
       
       5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             a���     �                  �               �                 OUTPUT_DIR="$PWD/kernel_out"5��                         )                      �                          *                      �                      7   +               e      �       2                 �                    5�_�                       6    ����                                                                                                                                                                                                                                                                                                                                                             a���     �                �rm -rf modules_install/lib; make INSTALL_MOD_PATH=./modules_install modules_install; find modules_install -type l -exec rm {} \;5��                          +       �               5�_�      	                     ����                                                                                                                                                                                                                                                                                                                                                             a���     �                �             5��                          *                      �                          *                      �                         *                     �                         *                     �                         *                     �                         *                     �                         *                     �                      	   *              	       �               	       
   *       	       
       �               
          *       
              �                         *                     �                         7                      5�_�      
           	          ����                                                                                                                                                                                                                                                                                                                                                             a���     �               PINENOTE_IP=$5��                         *                     �                         *                     �                         *                     5�_�   	              
          ����                                                                                                                                                                                                                                                                                                                                                             a���     �               PINENOTE_IP=${}5��                         *                     5�_�   
                        ����                                                                                                                                                                                                                                                                                                                                                             a���    �               PINENOTE_IP=${}5��                         8                      5�_�                       #    ����                                                                                                                                                                                                                                                                                                                                                             a���     �               qscp -r arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtb root@$PINENOTE_IP:/boot/dtbs/rockchip/rk3566-pinenote.dtb5��                        U                     �                        V                     �                        V                     �                     	   V              	       �              	       
   V       	       
       �              
       
   V       
       
       5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             a���     �               :scp -r modules_install/lib/modules root@$PINENOTE_IP:/lib/5��                        �                     �                        �                     �                     	   �              	       �              	       
   �       	       
       �              
       
   �       
       
       5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             a���     �                 7scp arch/arm64/boot/Image root@$PINENOTE_IP:/boot/Image5��                        �                     �                        �                     �                        �                     �                     	   �              	       �              	       
   �       	       
       �              
       
   �       
       
       �              
       
   �       
       
       5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             a���     �               `scp -r $OUTPUT_DIR/rk3566-pinenote.dtb root@$PINENOTE_IP:/boot/dtbs/rockchip/rk3566-pinenote.dtb5��                         R                      5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             a���     �               _scp r $OUTPUT_DIR/rk3566-pinenote.dtb root@$PINENOTE_IP:/boot/dtbs/rockchip/rk3566-pinenote.dtb5��                         R                      5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             a���     �               ^scp  $OUTPUT_DIR/rk3566-pinenote.dtb root@$PINENOTE_IP:/boot/dtbs/rockchip/rk3566-pinenote.dtb5��                         R                      5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             a���     �                6scp -r $OUTPUT_DIR/lib/modules root@$PINENOTE_IP:/lib/5��                          �       7               5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             a���    �               �               5��                          �               7       5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             a� �     �                 6scp -r $OUTPUT_DIR/lib/modules root@$PINENOTE_IP:/lib/5��                         �                      5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             a� �     �               3scp $OUTPUT_DIR/Image root@$PINENOTE_IP:/boot/Image5��                         �                      5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             a� �     �               ]scp $OUTPUT_DIR/rk3566-pinenote.dtb root@$PINENOTE_IP:/boot/dtbs/rockchip/rk3566-pinenote.dtb5��                         Q                      5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             a� �     �               _scp-v $OUTPUT_DIR/rk3566-pinenote.dtb root@$PINENOTE_IP:/boot/dtbs/rockchip/rk3566-pinenote.dtb5��                         Q                      5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             a� �    �               `scp -v $OUTPUT_DIR/rk3566-pinenote.dtb root@$PINENOTE_IP:/boot/dtbs/rockchip/rk3566-pinenote.dtb5��                        `                     5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             a� �     �                 7scp -rv $OUTPUT_DIR/lib/modules root@$PINENOTE_IP:/lib/5��                         �                      5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             a� �     �               6scp -v $OUTPUT_DIR/Image root@$PINENOTE_IP:/boot/Image5��                         �                      �                        �                     5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             a� �     �               `scp -v $OUTPUT_DIR/rk3566-pinenote.dtb root@$PINENOTE_IP:/boot/dtbs/rockchip/rk3566-pinenote.dtb5��                         `                      5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             a� �     �               ascp -v $OUTPUT_DIR}/rk3566-pinenote.dtb root@$PINENOTE_IP:/boot/dtbs/rockchip/rk3566-pinenote.dtb5��                         a                      5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             a� �     �               7scp -v $OUTPUT_DIR}/Image root@$PINENOTE_IP:/boot/Image5��                         �                      5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             a� �     �                 8scp -rv $OUTPUT_DIR}/lib/modules root@$PINENOTE_IP:/lib/5��                         �                      5�_�                        	    ����                                                                                                                                                                                                                                                                                                                                                             a� �     �                 7scp -rv $OUTPUT_DIR}lib/modules root@$PINENOTE_IP:/lib/5��               7       8   �       7       8       �               8       8   �       8       8       5�_�      !                      ����                                                                                                                                                                                                                                                                                                                                                             a� �     �               6scp -v $OUTPUT_DIR}Image root@$PINENOTE_IP:/boot/Image5��               6       7   �       6       7       �               7       7   �       7       7       5�_�       "           !          ����                                                                                                                                                                                                                                                                                                                                                             a� �     �               `scp -v $OUTPUT_DIR}rk3566-pinenote.dtb root@$PINENOTE_IP:/boot/dtbs/rockchip/rk3566-pinenote.dtb5��               `       a   N       `       a       �               a       a   N       a       a       5�_�   !   #           "          ����                                                                                                                                                                                                                                                                                                                                                             a� �    �               OUTPUT_DIR="$PWD/kernel_out"5��                         (                      5�_�   "   $           #          ����                                                                                                                                                                                                                                                                                                                                                             a� �     �               ascp -v ${OUTPUT_DIR}rk3566-pinenote.dtb root@$PINENOTE_IP:/boot/dtbs/rockchip/rk3566-pinenote.dtb5��                         S                      5�_�   #   %           $          ����                                                                                                                                                                                                                                                                                                                                                             a� �     �               `scp v ${OUTPUT_DIR}rk3566-pinenote.dtb root@$PINENOTE_IP:/boot/dtbs/rockchip/rk3566-pinenote.dtb5��                         S                      5�_�   $   &           %          ����                                                                                                                                                                                                                                                                                                                                                             a� �     �               _scp  ${OUTPUT_DIR}rk3566-pinenote.dtb root@$PINENOTE_IP:/boot/dtbs/rockchip/rk3566-pinenote.dtb5��                         S                      5�_�   %   '           &          ����                                                                                                                                                                                                                                                                                                                                                             a� �     �               7scp -v ${OUTPUT_DIR}Image root@$PINENOTE_IP:/boot/Image5��                         �                      5�_�   &   (           '          ����                                                                                                                                                                                                                                                                                                                                                             a� �     �               6scp v ${OUTPUT_DIR}Image root@$PINENOTE_IP:/boot/Image5��                         �                      5�_�   '   )           (          ����                                                                                                                                                                                                                                                                                                                                                             a� �     �               5scp  ${OUTPUT_DIR}Image root@$PINENOTE_IP:/boot/Image5��                         �                      5�_�   (   *           )          ����                                                                                                                                                                                                                                                                                                                                                             a� �     �                 8scp -rv ${OUTPUT_DIR}lib/modules root@$PINENOTE_IP:/lib/5��                         �                      5�_�   )   +           *          ����                                                                                                                                                                                                                                                                                                                                                             a� �     �                 7scp -r ${OUTPUT_DIR}lib/modules root@$PINENOTE_IP:/lib/5��                         �                      5�_�   *   ,           +          ����                                                                                                                                                                                                                                                                                                                                                             a� �    �                 6scp -r${OUTPUT_DIR}lib/modules root@$PINENOTE_IP:/lib/5��                         �                      5�_�   +   -           ,          ����                                                                                                                                                                                                                                                                                                                                                             a��    �                #!/bin/bash5��                                                5�_�   ,               -          ����                                                                                                                                                                                                                                                                                                                                                             a�    �               "PINENOTE_IP=${IP:-192.168.178.110}5��                         =                      �                        =                     �                        =                     �                     	   =              	       �              	       	   =       	       	       �              	       	   =       	       	       5��
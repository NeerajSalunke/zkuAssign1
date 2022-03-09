pragma circom 2.0.3;
include "./mimcsponge.circom";
template merkleroot(n) {
    signal input leaves[n];
    signal nonLeaf1[4];
    signal nonLeaf2[2];
    signal output root;

    component mimc1 = MiMCSponge(2,220,1);
    mimc1.ins[0] <== leaves[0];
    mimc1.ins[1] <== leaves[1];
    mimc1.k <== 0;

    nonLeaf1[0] <== mimc1.outs[0];


    component mimc2 = MiMCSponge(2,220,1);
    mimc2.ins[0] <== leaves[2];
    mimc2.ins[1] <== leaves[3];
    mimc2.k <== 0;

    nonLeaf1[1] <== mimc2.outs[0];


    component mimc3 = MiMCSponge(2,220,1);
    mimc3.ins[0] <== leaves[4];
    mimc3.ins[1] <== leaves[5];
    mimc3.k <== 0;

    nonLeaf1[2] <== mimc3.outs[0];


    component mimc4 = MiMCSponge(2,220,1);
    mimc4.ins[0] <== leaves[6];
    mimc4.ins[1] <== leaves[7];
    mimc4.k <== 0;

    nonLeaf1[3] <== mimc4.outs[0];


    component mimc5 = MiMCSponge(2,220,1);
    mimc5.ins[0] <== nonLeaf1[0];
    mimc5.ins[1] <== nonLeaf1[1];
    mimc5.k <== 0;

    nonLeaf2[0] <== mimc5.outs[0];


    component mimc6 = MiMCSponge(2,220,1);
    mimc6.ins[0] <== nonLeaf1[2];
    mimc6.ins[1] <== nonLeaf1[3];
    mimc6.k <== 0;

    nonLeaf2[1] <== mimc6.outs[0];


    component mimc7 = MiMCSponge(2,220,1);
    mimc7.ins[0] <== nonLeaf2[0];
    mimc7.ins[1] <== nonLeaf2[1];
    mimc7.k <== 0;

    root <== mimc7.outs[0];
}

component main {public[leaves]} = merkleroot(8);
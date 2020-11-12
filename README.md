# README

Wall times:

| Proof                                 | f2bde65aa (original) | 9c2df097e `assert_then_assume` (modified) | `complete_rewrite` |
|---------------------------------------|----------------------|-------------------------------------------|--------------------|
| `HTTPClient_AddHeader`                | 7m1.147s             | 12m34.362s                                | 9m24.694s          |
| `HTTPClient_AddRangeHeader`           | 3.058s               | 0m3.064s                                  | 0m3.737s           |
| `HTTPClient_InitializeRequestHeaders` | 5m9.417s             | 2m49.828s                                 | 2m51.882s          |
| `HTTPClient_Send`                     | 0m15.208s            | 0m14.988s                                 | 0m14.772s          |

`complete_rewrite` adds a `__CPROVER_assume` after all `assert` calls with `comby ' assert(:[cond]);' ' assert(:[cond]); __CPROVER_assume(:[cond]);' .c -stats -i`

By proof:

## `HTTPClient_AddHeader`

"Runtime decision procedure"

| Runtime decision procedure # | `original` | `assert_then_assume` | `complete_rewrite` |
|------------------------------|------------|----------------------|--------------------|
| 1                            | 419.596s   | 753.2s               | 563.585s           |

## `AddRangeHeader`

| Runtime decision procedure # | `original` | `assert_then_assume` | `complete_rewrite` |
|------------------------------|------------|----------------------|--------------------|
| 1                            | 0.516253s  | 0.570677s            | 0.570195s          |
| 2                            | 0.019884s  | 0.0237841s           | 0.00830389s        |
| 3                            | 2.21213s   | 1.73132s             | 2.1162s            |

## `HTTPClient_InitializeRequestHeaders`

| Runtime decision procedure # | `original` | `assert_then_assume` | `complete_rewrite` |
|------------------------------|------------|----------------------|--------------------|
| 1                            | 308.148s   | 168.911s             | 170.609s           |

## `HTTPClient_Send`

| Runtime decision procedure # | `original` | `assert_then_assume` | `complete_rewrite` |
|------------------------------|------------|----------------------|--------------------|
| 1                            | 13.3561s   | 13.8351s             | 13.0398s           |

# Setup

```
git clone https://github.com/natasha-jeppu/aws-iot-device-sdk-embedded-C
cd aws-iot-device-sdk-embedded-C
git checkout assert_then_assume
git submodule update --init --recursive
libraries/standard/http/cbmc/proofs
cd HTTPClient_AddHeader
make result
```

Refs: [`https://github.com/diffblue/cbmc/issues/5505`](https://github.com/diffblue/cbmc/issues/5505)


See `run.sh` scripts for each proof and `time-*` files for raw output.
